import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

/*
@author : Gayathri B    09/05/2025
@description : This function displays a custom modal bottom sheet that serves as an MPIN 
              (Mobile Personal Identification Number) entry interface. It includes:
              - A fingerprint icon for biometric authentication.
              - Four TextFields for entering a numeric MPIN.
              - A button to navigate to the Master Download page for checking progress.

@props      :
  - BuildContext context : The context in which the modal bottom sheet is displayed.
*/



void mpin(BuildContext context) {
  showModalBottomSheet<void>(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (BuildContext context) {
      final size = MediaQuery.of(context).size;
      String enteredMpin = '';

      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          height: size.height * 0.6,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Enter Your MPIN',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: IconButton(
                  onPressed: () {
                    // Implement biometric logic if needed
                  },
                  icon: const Icon(Icons.fingerprint, size: 40, color: Color(0xFF03096E)),
                ),
              ),
              const SizedBox(height: 20),
              PinCodeTextField(
                appContext: context,
                length: 4,
                obscureText: false,
                keyboardType: TextInputType.number,
                animationType: AnimationType.fade,
                onChanged: (value) {
                  enteredMpin = value;
                },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(10),
                  fieldHeight: size.height * 0.07,
                  fieldWidth: size.width * 0.15,
                  activeColor: Colors.black,
                  selectedColor: Colors.black,
                  inactiveColor: Colors.black,
                  activeFillColor: Colors.black,
                  selectedFillColor: Colors.black,
                  inactiveFillColor: Colors.black,
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 2, 59, 105),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(230, 40),
                  ),
                  onPressed: () async {
                    if (enteredMpin.length < 4) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please enter all 4 digits")),
                      );
                      return;
                    }

                    final prefs = await SharedPreferences.getInstance();
                    final storedMpin = prefs.getString('user_mpin');

                    if (storedMpin == enteredMpin) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("MPIN matched. Logging in...")),
                      );
                      Navigator.of(context).pop();
                      context.goNamed('home');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Incorrect MPIN. Try again.")),
                      );
                    }
                  },
                  child: const Text("Login"),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

