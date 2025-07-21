import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newsee/AppSamples/ReactiveForms/view/login_mpin.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

createMpin(BuildContext context) {
  // show the custom modal bottom sheet
  showModalBottomSheet<void>(
    isScrollControlled: true,
    backgroundColor: Colors.white,
    context: context,
    builder: (BuildContext context) {
      final size = MediaQuery.of(context).size;
      String pin = '';
      String confirmPin = '';
      final screenWidth = size.width;
      final screenHeight = size.height;
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          height: screenHeight * 0.82,
          decoration: BoxDecoration(),
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Align(
                child: Padding(
                  padding: const EdgeInsets.all(20),

                  child: Title(
                    color: Colors.black,
                    child: Text(
                      'Create  MPIN',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Set  MPIN',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  PinCodeTextField(
                    enablePinAutofill: false,
                    autoFocus: true,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    appContext: context,
                    length: 4,
                    obscureText: true,
                    blinkDuration: Duration(seconds: 1),
                    blinkWhenObscuring: true,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.underline,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      activeColor: Colors.black,
                      inactiveColor: Colors.black,
                      inactiveFillColor: Colors.white,
                      selectedFillColor: Colors.grey.shade200,
                      activeBorderWidth: 1,
                      inactiveBorderWidth: 1,
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: Colors.white12,
                    enableActiveFill: true,
                    onCompleted: (v) {
                      pin = v;
                      print("Set MPIN Completed => $pin");
                    },
                    onChanged: (value) {
                      print(value);
                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Confirm  MPIN',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  PinCodeTextField(
                    enablePinAutofill: false,
                    autoFocus: true,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    appContext: context,
                    length: 4,
                    obscureText: true,
                    blinkDuration: Duration(seconds: 1),
                    blinkWhenObscuring: true,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.underline,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      activeColor: Colors.black,
                      inactiveColor: Colors.black,
                      inactiveFillColor: Colors.white,
                      selectedFillColor: Colors.grey.shade200,
                      activeBorderWidth: 1,
                      inactiveBorderWidth: 1,
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: Colors.white12,
                    enableActiveFill: true,
                    onCompleted: (v) {
                      print("Completed");
                    },
                    onChanged: (value) {
                      print(value);
                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  ),
                ],
              ),

              SizedBox(height: 50),
              ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(
                    Color.fromARGB(255, 2, 59, 105),
                  ),
                  foregroundColor: WidgetStatePropertyAll(Colors.white),
                  minimumSize: WidgetStatePropertyAll(Size(230, 40)),
                ),
                onPressed: () {
                  context.pop();
                  mpin(context);
                },

                child: Text("Create"),
              ),
            ],
          ),
        ),
      );
    },
  );
}
