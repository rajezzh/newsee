abstract class CameraEvent {}

class CameraOpen extends CameraEvent {}

class CameraLensChange extends CameraEvent {}

class FlashModeChange extends CameraEvent {}

class CaptureImage extends CameraEvent {}

class CameraReCapture extends CameraEvent {}

class CameraExit extends CameraEvent {}