import 'dart:typed_data';

import 'package:camera/camera.dart';

class CameraState {}

class CameraIntialize extends CameraState {}

class CameraRun extends CameraState {
  final CameraController controller;
  CameraRun(this.controller);
}

class CameraFailure extends CameraState {
  final String errormsg;
  CameraFailure(this.errormsg);
}

class CameraCaptureData extends CameraState {
  final Uint8List imagedata;
  CameraCaptureData(this.imagedata);
}

class CameraConfirmData extends CameraState {
  // final Uint8List bytes;
  // CameraConfirmData(this.bytes);
  final XFile xfiledata;
  CameraConfirmData(this.xfiledata);
}

