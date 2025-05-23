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
import 'package:newsee/feature/masters/domain/repository/master_repo.dart';

class MasterRepoImpl extends MasterRepo {
  @override
  Future<AsyncResponseHandler<Failure, MasterResponse>> downloadMaster({
    required MasterRequest request,
  }) async {
    Response response = await MastersRemoteDatasource(
      dio: ApiClient().getDio(),
    ).downloadMaster(request);
    if (response.data['Success']) {
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
  }
}
