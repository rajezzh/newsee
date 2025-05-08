import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsee/blocs/camera/camera_bloc.dart';
import 'package:newsee/blocs/camera/camera_event.dart';
import 'package:newsee/blocs/camera/camera_state.dart';

class CameraView extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
  
    return BlocBuilder<CameraBloc, CameraState>(
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
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.camera),
                  onPressed: () => {context.read<CameraBloc>().add(CameraCapture())},
                  label: Text("Take Picture"))
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
        return const Center(child: Text("Initializing..."));
      }
    );
  }
}