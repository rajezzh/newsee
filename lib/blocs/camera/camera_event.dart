abstract class CameraEvent {}

class CameraOpen extends CameraEvent {}

class CameraCapture extends CameraEvent {}

class CameraReCapture extends CameraEvent {}

class CameraExit extends CameraEvent {}