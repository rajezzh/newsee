import 'package:dio/dio.dart';
import 'package:newsee/feature/auth/domain/model/user/user_model.dart';

class AuthRemoteDatasource {
  final Dio dio;

  AuthRemoteDatasource({required this.dio});

  Future<UserModel> loginWithUserAccount(String token) async {
    var request = await dio.post('user/login', data: {'token': token});

    return UserModel.fromJson(request.data);
  }
}
