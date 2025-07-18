import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newsee/AppSamples/ReactiveForms/view/login_mpin.dart';
import 'package:newsee/Utils/aes_utils.dart';
import 'package:newsee/Utils/convert_mpin.dart';
import 'package:newsee/Utils/mpin_encrypt.dart';
import 'package:newsee/Utils/utils.dart';
import 'package:newsee/core/api/api_client.dart';
import 'package:newsee/core/api/api_config.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

createMpin(BuildContext context) {
  // show the custom modal bottom sheet
  String pin = '';
  String confirmPin = '';

  showModalBottomSheet<void>(
    isScrollControlled: true,
    backgroundColor: Colors.white,
    context: context,
    builder: (BuildContext context) {
      final size = MediaQuery.of(context).size;
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
                    pinTheme: getPinTheme(),
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
                    pinTheme: getPinTheme(),
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: Colors.white12,
                    enableActiveFill: true,
                    onCompleted: (v) {
                      if (pin == v) {
                        confirmPin = v;
                      }
                      print("Completed");
                    },
                    onChanged: (value) {
                      print(pin);
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
                onPressed: () async {
                  try {
                    final encPinValue = encryptMPIN(
                      confirmPin,
                      'sysarc@1234INFO@',
                    );
                    print('enc pin => ${encPinValue.encryptedText}');
                    final response = await ApiClient().getDio().post(
                      ApiConfig.mpinEndpoint,
                      data: {
                        "mpin": encPinValue.encryptedText,
                        "userid": "AGRI1124",
                        "vertical": "7",
                        "token":
                            "U2FsdGVkX1/Wa6+JeCIOVLl8LTr8WUocMz8kIGXVbEI9Q32v7zRLrnnvAIeJIVV3",
                      },
                    );

                    if (response.statusCode != null &&
                        response.statusCode == 200) {
                      showSnack(
                        context,
                        message: 'MPIN Registered Successfully',
                      );
                      context.pop();
                      mpin(context);
                    }
                  } catch (e) {
                    print(
                      'Exception occured : mpin registration failed : stacktrace : $e',
                    );
                  }
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

PinTheme getPinTheme() {
  return PinTheme(
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
  );
}
