import 'package:dio/dio.dart';
import 'package:newsee/Model/api_core/AsyncResponseHandler.dart';
import 'package:newsee/Model/api_core/auth_failure.dart';
import 'package:newsee/Model/api_core/failure.dart';
import 'package:newsee/core/api/api_client.dart';
import 'package:newsee/core/api/api_config.dart';
import 'package:newsee/feature/masters/data/datasource/masters_remote_datasource.dart';
import 'package:newsee/feature/masters/domain/modal/lov.dart';
import 'package:newsee/feature/masters/domain/modal/master_request.dart';
import 'package:newsee/feature/masters/domain/modal/master_response.dart';
import 'package:newsee/feature/masters/domain/modal/post.dart';
import 'package:newsee/feature/masters/domain/repository/master_repo.dart';

class MasterRepoImpl extends MasterRepo {
  @override
  Future<AsyncResponseHandler<Failure, MasterResponse>> downloadMaster({
    required MasterRequest request,
  }) async {
    // Response response = await MastersRemoteDatasource(
    //   dio: ApiClient().getDio(),
    // ).downloadMaster(request);
    try {
      Response response =
          await MastersRemoteDatasource(
            dio: ApiClient().getDio(),
          ).downloadMasterOffline();

      parseResponse(response);

      final setupmaster = response.data['Setupmaster'];
      if (setupmaster && setupmaster['Listofvalues']) {
        var listofvalues = setupmaster['Listofvalues'];
        print(listofvalues);
        Lov lovResponse = Lov.fromJson(response.data['responseData']);
        List<Lov> lovList = [lovResponse];

        print('Lov.fromJson() => ${lovResponse.toString()}');
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

  parseResponse(Response response) {
    final List posts = response.data;
    List<Post> _posts = posts.map((e) => Post.fromMap(e)).toList();
    print(_posts[0].title);
    // now posts is a List contains Map<String,dynamic>
  }
}
