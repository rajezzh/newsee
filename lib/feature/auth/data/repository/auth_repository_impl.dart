import 'package:dio/dio.dart';
import 'package:newsee/Model/api_core/AsyncResponseHandler.dart';
import 'package:newsee/Model/api_core/auth_failure.dart';
import 'package:newsee/Model/api_core/failure.dart';
import 'package:newsee/Model/login_request.dart';
import 'package:newsee/feature/auth/data/datasource/auth_remote_datasource.dart';
import 'package:newsee/feature/auth/domain/model/user/auth_response_model.dart';
import 'package:newsee/feature/auth/domain/model/user/user_model.dart';
import 'package:newsee/feature/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoryImpl({required this.authRemoteDatasource});

  /* 
@author         : karthick.d  14/05/2025
@desc           : overide abstract method loginWithAccount from AuthRepository
                  this method calls authRemoteDatasource.loginWithUserAccount
                  method that perform dio.post to login service
@return         : Future<AsyncResponseHandler<Failure, UserModel>>
 */
  @override
  Future<AsyncResponseHandler<Failure, AuthResponseModel>> loginWithAccount(
    LoginRequest req,
  ) async {
    try {
      Map<String, dynamic> payload = {
        "Loginuser": req.username,
        "Loginpasswd": req.password,
        "IMEI": "42d084ddb553f47d",
        "LLdate": "2025-05-08 14:44:41",
        "Version": "0.0.20.5_lmsinbox_freeze",
        "Brach_code": "",
        "PdTab": "N",
        "Module": "HL",
      };

      print('auth request payload => $payload');
      var response = await authRemoteDatasource.loginWithUserAccount(payload);

      print('Auth Response => $response');
      print(
        'AsyncResponseHandler.right => ${AsyncResponseHandler.right(response).right}',
      );
      return AsyncResponseHandler.right(response);
    } on DioException catch (e) {
      return AsyncResponseHandler.left(
        AuthFailure(message: e.response?.data['error']),
      );
    } on Exception catch (e) {
      return AsyncResponseHandler.left(
        AuthFailure(message: 'Authentication Failure'),
      );
    }
  }
}
