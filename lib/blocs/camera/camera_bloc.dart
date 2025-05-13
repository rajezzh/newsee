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
    on<CameraLensChange>(camerachange);
    on<FlashModeChange>(cameraflash);
    on<CameraCapture>(cameracapture);
    on<CameraReCapture>(camerarecaptrue);
    on<CameraExit>(confirmimage);
  }

  void camerainit(event, emit) async {
    emit(CameraIntialize());
    try {
      cameras = await availableCameras();
      controller = CameraController(cameras[0], ResolutionPreset.ultraHigh, enableAudio: false);
      await controller?.initialize();
      emit(CameraRun(controller!));
    } catch (error) {
      emit(CameraFailure(error.toString()));
    }
  }

  void camerachange(event, emit) async {
    final lendir = controller?.description.lensDirection;
    print("lendir $lendir");
    if (lendir == CameraLensDirection.back) {
      final camerasetup = cameras.firstWhere((camera) => 
        camera.lensDirection == CameraLensDirection.front, 
        orElse: () => cameras.first
      );
      controller?.setDescription(camerasetup);
      controller?.initialize();
      emit(CameraRun(controller!));
    } else if (lendir == CameraLensDirection.front) {
      final camerasetup =  cameras.firstWhere((camera) => 
        camera.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first
      );
      controller?.setDescription(camerasetup);
      controller?.initialize();
      emit(CameraRun(controller!));
    } else {
      final camerasetup = cameras.firstWhere((camera) => 
        camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first
      );
      controller?.setDescription(camerasetup);
      controller?.initialize();
      emit(CameraRun(controller!));
    }
    print("Switched to ${cameras[0].lensDirection}");
  }

  void cameraflash(event, emit) async {
    if (controller?.value.flashMode == FlashMode.torch) {
      await controller?.setFlashMode(FlashMode.off);
      emit(CameraRun(controller!));
    } else {
      await controller?.setFlashMode(FlashMode.torch);
      emit(CameraRun(controller!));
    }
    
  }

  void cameracapture(event, emit) async {
    if (controller != null && controller!.value.isInitialized) {
      final imagestate = await controller!.takePicture();
      imageBytes = await imagestate.readAsBytes();
      if (controller?.value.flashMode == FlashMode.torch) {
        await controller?.setFlashMode(FlashMode.off);
      }
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
      // imageBytes = await imagestate.readAsBytes();
      emit(CameraConfirmData(imagestate));
    } else {
      print("Camera Capture Not Working");
    }
  }

  @override
  Future<void> close() {
    controller?.dispose();
    return super.close();
  }
}