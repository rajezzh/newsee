import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Define the function that take multiple pharameters and also take context
void maintenanceActionSheet(
  BuildContext context,
  String title,
  String message,
  IconData icon,
  String action1,
) {

  showCupertinoModalPopup<void>(
    context: context,
    builder:
        (BuildContext context) => CupertinoActionSheet(
          //Title Section of the CupertinoActionSheet
          title: Column(
            children: [
              //maintenance icon
              Icon(icon, size: 50, color: const Color.fromARGB(255, 3, 9, 110)),

              //title text with padding
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 50),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          message: Text(
            message,
            style: TextStyle(
              fontSize: 20,
              color: const Color.fromARGB(178, 0, 0, 0),
            ),
          ),
              //Axtions Button section
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              onPressed: () {
                //close the action sheet when pressed 
                Navigator.pop(context);
              },

              //Custom style button using ClipRRect
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    color: const Color.fromARGB(255, 3, 9, 110),
                    child: Text(
                      action1,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
  );
}
