## OCR feature for reading text from KYC's

camera live preview is used to extract text from camera preview stream

camera: ^0.11.1 - plugin is used for camera live preview
google_mlkit_text_recognition: ^0.15.0
// don't use google-ml-kit - 0.20.0 which is a bundle of all google-mlkit plugin
// which will increase the app bundle size and compile time / runtime dependencies
// refer this [GoogleMLKitPlugin] (https://pub.dev/packages/google_ml_kit)
