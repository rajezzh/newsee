import 'package:dio/dio.dart';
import 'package:newsee/core/api/AsyncResponseHandler.dart';
import 'package:newsee/core/api/api_client.dart';
import 'package:newsee/core/api/auth_failure.dart';
import 'package:newsee/core/api/failure.dart';
import 'package:newsee/core/api/http_connection_failure.dart';
import 'package:newsee/core/api/http_exception_parser.dart';
import 'package:newsee/feature/aadharvalidation/data/datasource/aadhar_validate_datasource.dart';
import 'package:newsee/feature/aadharvalidation/data/repository/aadhar_response_parser.dart';
import 'package:newsee/feature/aadharvalidation/domain/modal/aadharvalidate_request.dart';
import 'package:newsee/feature/aadharvalidation/domain/modal/aadharvalidate_response.dart';
import 'package:newsee/feature/aadharvalidation/domain/repository/aadharvalidate_repo.dart';

class AadharValidateImpl extends AadharvalidateRepo {
  @override
  Future<AsyncResponseHandler<Failure, AadharvalidateResponse>> validateAadhar({
    required AadharvalidateRequest request,
  }) async {
    AuthFailure failure = AuthFailure(message: "");
    try {
      var responseData = await AadharValidateDatasource(
        dio: ApiClient().getDio(),
      ).validateAadhaar(request);
      print('AadharValidateImpl---------->$responseData ');
      if (responseData.data['Success']) {
        final AadharvalidateResponse response = AadharvalidateResponse.fromMap(
          responseData.data['responseData']['data'],
        );
        return AsyncResponseHandler.right(response);
      } else {
        return AsyncResponseHandler.left(failure);
      }
      // if (response.data['Success']) {
      //   var aadharRespnse = AadharResponseParser().parseResponse(response);
      //   return AsyncResponseHandler.right(aadharRespnse);
      // } else {
      //   return AsyncResponseHandler.left(failure);
      // }
    } catch (error) {
      print(error);

      return AsyncResponseHandler.left(failure);
    }
    // on DioException catch (e) {
    //   HttpConnectionFailure failure =
    //       DioHttpExceptionParser(exception: e).parse();
    //   return AsyncResponseHandler.left(failure);
    // }
  }
}
