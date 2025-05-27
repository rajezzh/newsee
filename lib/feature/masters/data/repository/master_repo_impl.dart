import 'package:dio/dio.dart';
import 'package:newsee/Model/api_core/AsyncResponseHandler.dart';
import 'package:newsee/Model/api_core/auth_failure.dart';
import 'package:newsee/Model/api_core/failure.dart';
import 'package:newsee/core/api/api_client.dart';
import 'package:newsee/core/api/api_config.dart';
import 'package:newsee/core/db/db_config.dart';
import 'package:newsee/feature/masters/data/datasource/masters_remote_datasource.dart';
import 'package:newsee/feature/masters/domain/modal/lov.dart';
import 'package:newsee/feature/masters/domain/modal/master_request.dart';
import 'package:newsee/feature/masters/domain/modal/master_response.dart';
import 'package:newsee/feature/masters/domain/modal/post.dart';
import 'package:newsee/feature/masters/domain/repository/lov_crud_repo.dart';
import 'package:newsee/feature/masters/domain/repository/master_repo.dart';
import 'package:sqflite/sqlite_api.dart';

class MasterRepoImpl extends MasterRepo {
  @override
  Future<AsyncResponseHandler<Failure, MasterResponse>> downloadMaster({
    required MasterRequest request,
  }) async {
    try {
      // Response response =
      //     await MastersRemoteDatasource(
      //       dio: ApiClient().getDio(),
      //     ).downloadMasterOffline();

      Response response = await MastersRemoteDatasource(
        dio: ApiClient().getDio(),
      ).downloadMaster(request);

      final setupmaster = response.data['Setupmaster'];
      if (setupmaster != null && setupmaster['Listofvalues'] != null) {
        List<dynamic> listofvalues = setupmaster['Listofvalues'];

        List<Lov> lovList = parseResponse(listofvalues);

        /* Listofvalue master downloaded and saved in table */

        Database db = await DBConfig().database;
        Iterator<Lov> it = lovList.iterator;
        LovCrudRepo lovCrudRepo = LovCrudRepo(db);
        while (it.moveNext()) {
          lovCrudRepo.save(it.current);
        }

        List<Lov> lovs = await lovCrudRepo.getAll();
        print('lovCrudRepo.getAllTasks() => ${lovs.length}');
        return AsyncResponseHandler.right(MasterResponse(master: lovList));
      } else {
        // api response success : false , process error message
        var errorMessage = response.data['errorDesc'];
        print('on Error request.data["ErrorMessage"] => $errorMessage');
        return AsyncResponseHandler.left(AuthFailure(message: errorMessage));
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

  List<Lov> parseResponse(List<dynamic> values) {
    final List resp = values;
    List<Lov> lovList = resp.map((e) => Lov.fromMap(e)).toList();
    print(lovList[0].Header);
    return lovList;
  }
}
