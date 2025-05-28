import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newsee/AppData/app_api_constants.dart';
import 'package:newsee/Model/api_core/AsyncResponseHandler.dart';
import 'package:newsee/Model/api_core/auth_failure.dart';
import 'package:newsee/Model/api_core/failure.dart';
import 'package:newsee/core/api/api_client.dart';
import 'package:newsee/core/api/api_config.dart';
import 'package:newsee/core/db/db_config.dart';
import 'package:newsee/feature/masters/data/datasource/masters_remote_datasource.dart';
import 'package:newsee/feature/masters/data/repository/lov_parser_impl.dart';
import 'package:newsee/feature/masters/data/repository/product_master_parser_impl.dart';
import 'package:newsee/feature/masters/data/repository/product_parser_impl.dart';
import 'package:newsee/feature/masters/data/repository/productschema_parser_impl.dart';
import 'package:newsee/feature/masters/domain/modal/lov.dart';
import 'package:newsee/feature/masters/domain/modal/master_request.dart';
import 'package:newsee/feature/masters/domain/modal/master_response.dart';
import 'package:newsee/feature/masters/domain/modal/master_types.dart';
import 'package:newsee/feature/masters/domain/modal/post.dart';
import 'package:newsee/feature/masters/domain/modal/product.dart';
import 'package:newsee/feature/masters/domain/modal/product_master.dart';
import 'package:newsee/feature/masters/domain/modal/productschema.dart';
import 'package:newsee/feature/masters/domain/repository/lov_crud_repo.dart';
import 'package:newsee/feature/masters/domain/repository/master_repo.dart';
import 'package:newsee/feature/masters/domain/repository/product_schema_crud_repo.dart';
import 'package:newsee/feature/masters/domain/repository/products_crud_repo.dart';
import 'package:newsee/feature/masters/domain/repository/products_master_crud_repo.dart';
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
            masterResponse = MasterResponse(
              master: lovList,
              masterType: MasterTypes.products,
            );
          } else {
            // api response success : false , process error message
            var errorMessage = response.data['errorDesc'];
            print('on Error request.data["ErrorMessage"] => $errorMessage');
            failure = AuthFailure(message: errorMessage);
          }

        case ApiConstants.master_key_products:
          masterTypes = MasterTypes.products;
          Response response = await MastersRemoteDatasource(
            dio: ApiClient().getDio(),
          ).downloadMaster(request);
          List<Product> productsList = ProductParserImpl().parseResponse(
            response,
          );
          List<ProductMaster> productmasterList = ProductMasterParserImpl().parseResponse(
            response
          );
          print("productmasterList is printing here => $productmasterList");
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
            // masterResponse = MasterResponse(
            //   master: productsList,
            //   masterType: MasterTypes.productschema,
            // );
          } else {
            var errorMessage = response.data['errorDesc'];
            print('on Error request.data["ErrorMessage"] => $errorMessage');
            failure = AuthFailure(message: errorMessage);
          }

          if (productmasterList.isNotEmpty) {
            // insert products in to products table
            Iterator<ProductMaster> it = productmasterList.iterator;
            ProductMasterCrudRepo productsMasterCrudRepo = ProductMasterCrudRepo(db);
            while (it.moveNext()) {
              productsMasterCrudRepo.save(it.current);
            }
            print('Products saved in db successfully... ');
            List<ProductMaster> p = await productsMasterCrudRepo.getAll();
            print('productCrudRepo.getAll() => ${p.length}');
            masterResponse = MasterResponse(
              master: productmasterList,
              masterType: MasterTypes.productschema,
            );
          } else {
            var errorMessage = response.data['errorDesc'];
            print('on Error request.data["ErrorMessage"] => $errorMessage');
            failure = AuthFailure(message: errorMessage);
          }

        case ApiConstants.master_key_productschema:
          masterTypes = MasterTypes.productschema;
          Response response = await MastersRemoteDatasource(dio: ApiClient().getDio()).downloadMaster(request);
          List<ProductSchema>productSchemaList =  ProductSchemaParserImpl().parseResponse(response);

          if (productSchemaList.isNotEmpty) {
            Iterator<ProductSchema> it = productSchemaList.iterator;
            ProductSchemaCrudRepo productSchemaCrudRepo = ProductSchemaCrudRepo(db);
            while (it.moveNext()) {
              productSchemaCrudRepo.save(it.current);
            }
            print('Products Schema saved in db successfully... ');
            List<ProductSchema> p = await productSchemaCrudRepo.getAll();
            print('productSchemaCrudRepo.getAll() => ${p.length}');
            masterResponse = MasterResponse(
              master: productSchemaList,
              masterType: MasterTypes.productschema,
            );
          }

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

  // now lov is a List contains Map<String,dynamic>
}
