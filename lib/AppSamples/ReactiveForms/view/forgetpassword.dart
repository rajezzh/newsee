import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Define the function that take multiple pharmeter

void forgetActionSheet(
  BuildContext context,
  String title,
  String message,
  IconData icon,
  String action1, 
  String action2, 
) {

  // popup the modal sheet 
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      //title section of the action sheet 
      title: Column(
        children: [
          // display the icon
          Icon(icon, size: 50, color: const Color.fromARGB(255, 3, 9, 110)),
          //add some spacing and disply the title
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 8),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      // below the title message
      message: Text(
        message,
        style: const TextStyle(fontSize: 16, color: CupertinoColors.black),
      ),
      // Two action Button 
      actions:
       <CupertinoActionSheetAction>[
        //Cancel First action Button 
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(action2), 
        ),
        //Continue Second action Button
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(action1), 
        ),
      ],
    ),
  );
}
