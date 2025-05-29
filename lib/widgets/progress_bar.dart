import 'package:flutter/material.dart';

class ProgressBarExample extends StatelessWidget {
  final double progressValue = 0.6; 

  @override
  Widget build(BuildContext context) {
    return Container(
      
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: CircularProgressIndicator(
                  value: progressValue,
                  backgroundColor: Colors.grey[300],
                  color: Colors.blue,
                  strokeWidth: 15,
                  
      
                ),
              ),
              progressValue == 1.0 
              ?
              Icon(Icons.check_circle,
              size: 50,
              color: Colors.green,
              ):
              Text(
                "${(progressValue * 100).toInt()}%",

                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,decoration: TextDecoration.none),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
