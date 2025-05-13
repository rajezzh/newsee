import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:newsee/blocs/camera/camera_bloc.dart';
import 'package:newsee/blocs/camera/camera_event.dart';
import 'package:newsee/blocs/camera/camera_state.dart';

class CameraView extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    final intwidth = (screenwidth * 0.5).round();
    final intheight = (screenheight * 0.5).round();
  
    return BlocConsumer<CameraBloc, CameraState>(
      listener: (context, state)  async {
        if (state is CameraConfirmData) {
          final cropdata = await ImageCropper().cropImage(
              sourcePath: state.xfiledata.path,
              uiSettings: [
                AndroidUiSettings(
                  toolbarTitle: 'Cropper',
                  toolbarColor: Colors.deepOrange,
                  toolbarWidgetColor: const Color.fromRGBO(255, 255, 255, 1),
                  initAspectRatio: CropAspectRatioPreset.square,
                  lockAspectRatio: false,
                  aspectRatioPresets: [
                    CropAspectRatioPreset.original,
                    CropAspectRatioPreset.square,
                    CropAspectRatioPreset.ratio4x3,
                    CropAspectRatioPresetCustom(),
                  ],
                ),
                WebUiSettings(
                  context: context,
                  presentStyle: WebPresentStyle.dialog,
                  size: CropperSize(
                    width: intwidth,
                    height: intheight,
                  ),
                ),
              ]
          );
          final imageBytes = await cropdata?.readAsBytes();
          print("cropdata-imageBytes $imageBytes");
          context.pop(imageBytes);
          }
        },
      builder: (context, state) {
        if (state is CameraIntialize) {
          return const Center(child: CircularProgressIndicator());
        }
        else if (state is CameraRun) {
          return Stack(
            children: [
              SizedBox.expand(
                child: CameraPreview(state.controller)
              ),
              Positioned(
                top: (screenheight * 0.8),
                width: screenwidth,
                child: Material(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Ink(
                            decoration: ShapeDecoration(
                              color: Colors.lightBlue,
                              shape: CircleBorder()
                            ),
                            child:  IconButton(
                              icon: const Icon(Icons.camera),
                              onPressed: () => {context.read<CameraBloc>().add(CameraCapture())},
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Ink(
                            decoration: ShapeDecoration(
                              color: Colors.lightBlue,
                              shape: CircleBorder()
                            ),
                            child:  IconButton(
                              icon: Icon((state.controller.description.lensDirection == CameraLensDirection.front) ? Icons.camera_front : Icons.camera_rear),
                              onPressed: () => {context.read<CameraBloc>().add(CameraLensChange())},
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Ink(
                            decoration: ShapeDecoration(
                              color: Colors.lightBlue,
                              shape: CircleBorder()
                            ),
                            child:  IconButton(
                              icon: Icon((state.controller.value.flashMode == FlashMode.torch) ? Icons.flash_on : Icons.flash_off),
                              onPressed: () => {context.read<CameraBloc>().add(FlashModeChange())},
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  
                )

                
              )
            ],
          );
        }
        else if (state is CameraCaptureData) {
          return Stack(
            children: [
              SizedBox.expand(
                child: Image.memory(
                  state.imagedata,
                  width: double.infinity,
                  height: double.infinity,
                )  
              ),
              Positioned(
                top: (screenheight * 0.8),
                left: (screenwidth * 0.2),
                child: Center(
                  child: ElevatedButton.icon(
                  icon: const Icon(Icons.camera),
                  onPressed: () => {context.read<CameraBloc>().add(CameraReCapture())},
                  label: Text("Capture"))
                ),
              ),
              Positioned(
                top: (screenheight * 0.8),
                left: (screenwidth * 0.6),
                child: Center(
                  child: ElevatedButton.icon(
                  icon: const Icon(Icons.check),
                  onPressed: () => {
                  context.read<CameraBloc>().add(CameraExit())
                  },
                  label: Text("Ok"))
                ),
              )
            ],
          );
        }
        return const Center(child: CircularProgressIndicator());
      }
    );
  }
}

class CropAspectRatioPresetCustom implements CropAspectRatioPresetData {
  @override
  (int, int)? get data => (2, 3);

  @override
  String get name => '2x3 (customized)';
}