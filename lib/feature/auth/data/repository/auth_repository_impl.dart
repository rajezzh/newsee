import 'package:newsee/Model/api_core/AsyncResponseHandler.dart';
import 'package:newsee/Model/api_core/failure.dart';
import 'package:newsee/feature/auth/data/datasource/auth_remote_datasource.dart';
import 'package:newsee/feature/auth/domain/model/user/user_model.dart';
import 'package:newsee/feature/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoryImpl({required this.authRemoteDatasource});

  @override
  Future<AsyncResponseHandler<Failure, UserModel>> loginWithAccount() {}
}
