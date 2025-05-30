import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsee/feature/progressbar/presentation/bloc/progressbar_bloc.dart';

/*
@author : Gayathri.b       27/05/2025
@description : Displays a circular progress indicator with a percentage value in the center.
         When the progress reaches 100%, a green checkmark icon is shown instead of the percentage.

 */

class ProgressBarExample extends StatelessWidget {
  // define the progressValue
  // total 
  // Math.round(state.total / state.current) 
 /*
  class DownloadProgressState{

    double? downloadedPercentage;


  }
*/
  final double progressValue = 0.6; // downloadedPercentage

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProgressBarBloc, ProgressbarState>(
        builder: (context, state) {
          final progressvalue;
          if (state is ProgressValueSet) {
            progressvalue = state.progresSetValue;
          } else {
            progressvalue = 0;
          }
          
          return Container(
            padding: EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Displays a circular progress indicator
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: CircularProgressIndicator(
                        value: progressvalue,
                        backgroundColor: Colors.grey[300],
                        color: Colors.blue,
                        strokeWidth: 15,
                      ),
                    ),

                    //  When the progress reaches 100%, a green checkmark icon is shown instead of the percentage.
                    progressvalue == 1.0
                        ? Icon(Icons.check_circle, size: 50, color: Colors.green)
                        :
                        // a percentage value in the center
                        Text(
                          "${(progressvalue * 100).toInt()}%",

                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                        ),
                  ],
                
                ),
                ElevatedButton(
                    child: Text("onpress"),
                    onPressed: () => {context.read<ProgressBarBloc>().add(ProgressFetchEvent(progressValue: (progressvalue + 0.1)))},
                  )
              ],
            ),
          );
        }

    );
    
  }
}
