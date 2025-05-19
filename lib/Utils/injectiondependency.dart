import 'package:get_it/get_it.dart';
import 'package:newsee/Model/login_request.dart';
import 'package:newsee/blocs/camera/camera_bloc.dart';
import 'package:newsee/blocs/login/login_bloc.dart';



final getIt = GetIt.instance;

void dependencyInjection() {
  getIt.registerFactory<CameraBloc>(() => CameraBloc());
  getIt.registerFactory<LoginBloc>(() => LoginBloc(loginRequest: LoginRequest(username: '', password: '')));
}