import 'package:get_it/get_it.dart';
import 'package:newsee/Utils/geolocator.dart';
import 'package:newsee/blocs/camera/camera_bloc.dart';



final getIt = GetIt.instance;

void dependencyInjection() {
  getIt.registerFactory<CameraBloc>(() => CameraBloc());
  getIt.registerFactory<MediaHandler>(() => MediaHandler());
}