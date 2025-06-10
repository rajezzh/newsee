/*
 @created on : May 16,2025
 @author : Akshayaa 
 Description : A reusable reactive text field integrated with the reactive forms package.
*/

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

Widget CustomTextField(String controlName, String label, [bool? mantatory]) {
  bool setUpperCase() {
    if (controlName == 'pan') return true;
    return false;
  }

  return Padding(
    padding: const EdgeInsets.all(16),
    child: ReactiveTextField<String>(
      formControlName: controlName,
      textCapitalization:
          setUpperCase()
              ? TextCapitalization.characters
              : TextCapitalization.none,
      validationMessages: {
        ValidationMessage.required: (error) => '$label is required',
        ValidationMessage.email: (error) => 'Enter valid $label',
        ValidationMessage.pattern: (error) => 'Enter valid $label',
      },
      decoration: InputDecoration(
        label: RichText(
          text: TextSpan(
            text: label,
            style: TextStyle(color: Colors.black, fontSize: 16),
            children: [
              TextSpan(
                text: mantatory == null ? ' *' : '',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
