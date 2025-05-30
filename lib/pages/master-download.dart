import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsee/blocs/progress/progress_bloc.dart';
import 'package:newsee/widgets/skeleton.dart';
import '../widgets/progress_bar.dart';

/*
@author : Gayathri.b    19/05/2025
@description : Displays a download screen UI with a progress bar and skeleton loaders,
             simulating content loading for "Download Master".





 */

class MasterDownload extends StatelessWidget {
  //customaized with and height

  @override
  Widget build(BuildContext context) {
    final double scrwidth = MediaQuery.of(context).size.width;
    final double scrheight = MediaQuery.of(context).size.height;

    return BlocProvider<ProgressBloc>(
      create: (context) => ProgressBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,

        body: BlocListener<ProgressBloc, ProgressState>(
          listener: (context, state) {
            print('current progress => ${state.downloadProgress}');
          },
          child: BlocBuilder<ProgressBloc, ProgressState>(
            builder: (context, state) {
              return SizedBox(
                width: scrwidth,
                height: scrheight,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //use the reusable widget ProgressBar
                        ProgressBarExample(
                          progressValue: state.downloadProgress,
                        ),
                        const SizedBox(width: 30),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //use the reusable widget SkeletonLoader
                            SkeletonLoader(
                              height: 20,
                              // child: Container(),
                            ),
                            SizedBox(height: 10),
                            SkeletonLoader(
                              height: 15,
                              width: 80,
                              // child: Container(),
                            ),
                            SizedBox(height: 10),
                            SkeletonLoader(
                              height: 15,
                              width: 100,
                              // child: Container(),
                            ),
                            SizedBox(height: 10),

                            SkeletonLoader(
                              height: 15,
                              // child: Container(),
                            ),
                            SizedBox(height: 10),

                            SkeletonLoader(
                              height: 10,
                              width: 110,
                              // child: Container(),
                            ),
                            const SizedBox(height: 15),
                            // Text the Download Master
                            const Text(
                              'Download Master',
                              style: TextStyle(
                                color: Color.fromRGBO(214, 24, 24, 1),
                                fontSize: 20,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                        Container(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
