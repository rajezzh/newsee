import 'package:dio/dio.dart';
import 'package:newsee/core/api/api_config.dart';
import 'package:newsee/feature/auth/domain/model/user/auth_response_model.dart';

class AuthRemoteDatasource {
  final Dio dio;

  AuthRemoteDatasource({required this.dio});

  Future<AuthResponseModel> loginWithUserAccount(
    Map<String, dynamic> payload,
  ) async {
    var request = await dio.post(
      'LoginService',
      data: {'Login': payload, 'token': ApiConfig.AUTH_TOKEN},
    );
    if (request.data['Success']) {
      print(request.data['Success']);
    } else {
      print('request.data["Success"] => ${request.data['Success']}');
    }
    var _authResponse = AuthResponseModel.fromJson(
      request.data['responseData'],
    );
    print('AuthResponseModel.fromJson() => ${_authResponse.toString()}');
    return _authResponse;
  }
}

/* 


{
    "Login": {
        "Loginuser": "HL03",
        "Loginpasswd": "laps",
        "IMEI": "42d084ddb553f47d",
        "LLdate": "2025-05-08 14:44:41",
        "Version": "0.0.20.5_lmsinbox_freeze",
        "Brach_code": "",
        "PdTab": "N",
        "Module": "HL"
    },
    "token": "U2FsdGVkX1/Wa6+JeCIOVLl8LTr8WUocMz8kIGXVbEI9Q32v7zRLrnnvAIeJIVV3"
}
 */
