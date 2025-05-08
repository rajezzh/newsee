import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsee/blocs/camera/camera_event.dart';
import 'package:newsee/blocs/camera/camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraController? controller;
  Uint8List?  imageBytes;
  late List<CameraDescription> cameras;

  CameraBloc(): super(CameraIntialize()) {
    on<CameraOpen>(camerainit);
    on<CameraCapture>(cameracapture);
    on<CameraExit>(confirmimage);
  }

  void camerainit(event, emit) async {
    emit(CameraIntialize());
    try {
      cameras = await availableCameras();
      controller = CameraController(cameras[0], ResolutionPreset.max);
      await controller?.initialize();
      emit(CameraRun(controller!));
    } catch (error) {
      emit(CameraFailure(error.toString()));
    }
  }

  void cameracapture(event, emit) async {
    if (controller != null && controller!.value.isInitialized) {
      final imagestate = await controller!.takePicture();
      imageBytes = await imagestate.readAsBytes();
      emit(CameraCaptureData(imageBytes!));
    } else {
      print("Camera Capture Not Working");
    }
  }

  void camerarecaptrue(event, emit) async {
    await controller?.initialize();
    emit(CameraRun(controller!));
  }

  void confirmimage(event, emit) async {
     if (controller != null && controller!.value.isInitialized) {
      final imagestate = await controller!.takePicture();
      imageBytes = await imagestate.readAsBytes();
      emit(CameraConfirmData(imageBytes!));
    } else {
      print("Camera Capture Not Working");
    }
  }
}