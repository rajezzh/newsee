import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsee/AppSamples/ReactiveForms/view/camera_view.dart';
import 'package:newsee/blocs/camera/camera_bloc.dart';
import 'package:newsee/blocs/camera/camera_event.dart';

class Camera extends StatelessWidget {
  const Camera({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CameraBloc()..add(CameraOpen()),
      child: CameraView(),
    );
  }
}