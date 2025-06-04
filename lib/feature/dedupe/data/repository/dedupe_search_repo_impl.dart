import 'package:dio/dio.dart';
import 'package:newsee/core/api/AsyncResponseHandler.dart';
import 'package:newsee/core/api/api_client.dart';
import 'package:newsee/core/api/auth_failure.dart';
import 'package:newsee/core/api/failure.dart';
import 'package:newsee/core/api/http_connection_failure.dart';
import 'package:newsee/core/api/http_exception_parser.dart';
import 'package:newsee/feature/dedupe/data/datasource/dedupe_serach_datasource.dart';
import 'package:newsee/feature/dedupe/domain/model/deduperesponse.dart';
import 'package:newsee/feature/dedupe/domain/repositoy/deduperepository.dart';

class DedupeSearchRepositoryimpl implements DedupeRepository {

  @override
  Future<AsyncResponseHandler<Failure, DedupeResponse>> dedupeSearchforCustomer(request) async {
    try {
      final payload = {
        "panCard": "GIBPD5981W",
        "aadharCard": "123456789012",
        "uaadhar": "121214543532",
        "gst": "12421412142112",
        "mobileno": "9025434524",
        "vertical": "7",
        "userid": "1234",
        "token": "U2FsdGVkX1/Wa6+JeCIOVLl8LTr8WUocMz8kIGXVbEI9Q32v7zRLrnnvAIeJIVV3"
      };
      var response = await DedupeDataSource(dio: ApiClient().getDio()).dedupeSearchcustomer(payload);

      if (response.data['Success']) {
        print("response.data['responseData'] ${response.data['responseData']}");
        var dedupResponse = DedupeResponse.fromJson(
          response.data['responseData'],
        );

        // print('DedupeResponse.fromJson() => ${dedupResponse.toString()}');
        return AsyncResponseHandler.right(dedupResponse);
      } else {
        // api response success : false , process error message
        var errorMessage = response.data['ErrorMessage'];
        print('on Error request.data["ErrorMessage"] => $errorMessage');
        return AsyncResponseHandler.left(AuthFailure(message: errorMessage));
      }
    } on DioException catch (e) {
      HttpConnectionFailure failure =
        DioHttpExceptionParser(exception: e).parse();
        return AsyncResponseHandler.left(failure);
    }
  }
}