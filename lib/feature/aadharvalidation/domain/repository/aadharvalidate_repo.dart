import 'package:newsee/core/api/AsyncResponseHandler.dart';
import 'package:newsee/core/api/failure.dart';
import 'package:newsee/feature/aadharvalidation/domain/modal/aadharvalidate_request.dart';
import 'package:newsee/feature/aadharvalidation/domain/modal/aadharvalidate_response.dart';

abstract class AadharvalidateRepo {
  Future<AsyncResponseHandler<Failure, AadharvalidateResponse>> validateAadhar({
    required AadharvalidateRequest request,
  });
}
