import 'package:dio/dio.dart';
import 'package:newsee/AppData/app_api_constants.dart';
import 'package:newsee/AppData/globalconfig.dart';
import 'package:newsee/core/api/AsyncResponseHandler.dart';
import 'package:newsee/core/api/api_client.dart';
import 'package:newsee/core/api/api_config.dart';
import 'package:newsee/core/api/auth_failure.dart';
import 'package:newsee/core/api/failure.dart';
import 'package:newsee/core/db/db_config.dart';
import 'package:newsee/feature/masters/data/datasource/masters_remote_datasource.dart';
import 'package:newsee/feature/masters/data/repository/lov_parser_impl.dart';
import 'package:newsee/feature/masters/data/repository/product_parser_impl.dart';
import 'package:newsee/feature/masters/domain/modal/lov.dart';
import 'package:newsee/feature/masters/domain/modal/master_request.dart';
import 'package:newsee/feature/masters/domain/modal/master_response.dart';
import 'package:newsee/feature/masters/domain/modal/master_types.dart';
import 'package:newsee/feature/masters/domain/modal/master_version.dart';
import 'package:newsee/feature/masters/domain/modal/post.dart';
import 'package:newsee/feature/masters/domain/modal/product.dart';
import 'package:newsee/feature/masters/domain/repository/lov_crud_repo.dart';
import 'package:newsee/feature/masters/domain/repository/master_repo.dart';
import 'package:newsee/feature/masters/domain/repository/masterversion_crud_repo.dart';
import 'package:newsee/feature/masters/domain/repository/products_crud_repo.dart';
import 'package:sqflite/sqlite_api.dart';

class MasterRepoImpl extends MasterRepo {
  @override
  Future<AsyncResponseHandler<Failure, MasterResponse>> downloadMaster({
    required MasterRequest request,
  }) async {
    /* initializing types required for AsyncResponseHandler Object */

    MasterTypes masterTypes = MasterTypes.lov;
    Database db = await DBConfig().database;
    MasterResponse masterResponse = MasterResponse(
      master: [],
      masterType: masterTypes,
    );
    AuthFailure failure = AuthFailure(message: "");
    
    try {
      switch (request.setupTypeOfMaster) {
        case ApiConstants.master_key_lov:
          /* Lov Master fetch from API and Save in respective table */
          masterTypes = MasterTypes.lov;
          Response response = await MastersRemoteDatasource(
            dio: ApiClient().getDio(),
          ).downloadMaster(request);

          final String versionFromResponse = response.data['version'] ?? request.setupVersion;
          final String masterNameFromResponse = response.data['masterName'] ?? request.setupTypeOfMaster;

          List<Lov> lovList = LovParserImpl().parseResponse(response);
          if (lovList.isNotEmpty) {
            /* Listofvalue master downloaded and saved in table */

            Iterator<Lov> it = lovList.iterator;
            LovCrudRepo lovCrudRepo = LovCrudRepo(db);
            while (it.moveNext()) {
              lovCrudRepo.save(it.current);
            }

            List<Lov> lovs = await lovCrudRepo.getAll();
            print('lovCrudRepo.getAll() => ${lovs.length}');

            // Save the updated master version into the db
            updateMasterVersion(db, masterNameFromResponse, versionFromResponse, 'success');

            //Update the global master version with the latest downloaded version
            Globalconfig.masterVersionMapper[request.setupTypeOfMaster] = versionFromResponse;
            
            print("Master Name: $masterNameFromResponse, Version: $versionFromResponse, Success");

            masterResponse = MasterResponse(
              master: lovList,
              masterType: MasterTypes.products,
            );
          } else {
            // api response success : false , process error message
            var errorMessage = response.data['errorDesc'];
            print('on Error request.data["ErrorMessage"] => $errorMessage');

            updateMasterVersion(db, masterNameFromResponse, versionFromResponse, 'failure');

            print("Master Name: $masterNameFromResponse, Version: $versionFromResponse, Failure");

            failure = AuthFailure(message: errorMessage);
          }

        case ApiConstants.master_key_products:
          masterTypes = MasterTypes.products;
          Response response = await MastersRemoteDatasource(
            dio: ApiClient().getDio(),
          ).downloadMaster(request);

          final String versionFromResponse = response.data['version'] ?? request.setupVersion;
          final String masterNameFromResponse = response.data['masterName'] ?? request.setupTypeOfMaster;

          List<Product> productsList = ProductParserImpl().parseResponse(
            response,
          );
          if (productsList.isNotEmpty) {
            // insert products in to products table
            Iterator<Product> it = productsList.iterator;
            ProductsCrudRepo productsCrudRepo = ProductsCrudRepo(db);
            while (it.moveNext()) {
              productsCrudRepo.save(it.current);
            }
            print('Products saved in db successfully... ');
            List<Product> p = await productsCrudRepo.getAll();
            print('productCrudRepo.getAll() => ${p.length}');

            updateMasterVersion(db, masterNameFromResponse, versionFromResponse, 'success');

            Globalconfig.masterVersionMapper[request.setupTypeOfMaster] = versionFromResponse;

            print("Master Name: $masterNameFromResponse, Version: $versionFromResponse, Success");

            masterResponse = MasterResponse(
              master: productsList,
              masterType: MasterTypes.productschema,
            );
          } else {
            var errorMessage = response.data['errorDesc'];
            print('on Error request.data["ErrorMessage"] => $errorMessage');

            updateMasterVersion(db, masterNameFromResponse, versionFromResponse, 'failure');

            print("Master Name: $masterNameFromResponse, Version: $versionFromResponse, Failure");

            failure = AuthFailure(message: errorMessage);
          }

        // case ApiConstants.master_key_productschema:
        //   masterTypes = MasterTypes.productschema;

        // default:
        //   break;
      }

      // returning AsyncResponseHandler...

      if (masterResponse.master.isNotEmpty) {
        return AsyncResponseHandler.right(masterResponse);
      } else {
        return AsyncResponseHandler.left(failure);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        print(
          'Connection error: Check if the server is running or use the correct IP/port.',
        );
        return AsyncResponseHandler.left(AuthFailure(message: e.toString()));
      } else {
        print('Dio error: $e');
      }
      return AsyncResponseHandler.left(AuthFailure(message: e.toString()));
    }
  }

  Future<void> updateMasterVersion(

    Database db , 
    String masterNameFromResponse , 
    String versionFromResponse,
    String isMasterDownloadSuccess ) async {
              final masterVersionCrudRepo = MasterversionCrudRepo(db);

                  await masterVersionCrudRepo.insert(MasterVersion(
            mastername: masterNameFromResponse,
            version: versionFromResponse,
            status: isMasterDownloadSuccess,
            ));
  }

  // now lov is a List contains Map<String,dynamic>
}
