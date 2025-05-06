import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newsee/AppSamples/ReactiveForms/config/appconfig.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginpageView extends StatelessWidget {
  const LoginpageView({super.key});

  @override
  Widget build(BuildContext context) {
    final loginFormgroup = AppConfig().loginFormgroup;
    return ReactiveForm(
      formGroup: loginFormgroup,
      child: Center(
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ReactiveTextField(
                formControlName: 'username',
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                validationMessages: {
                  ValidationMessage.required: (error) => 'UserName is Required',
                  ValidationMessage.contains: (error) => error as String,
                },
              ),
              SizedBox(height: 10.0),
              ReactiveTextField(
                formControlName: 'password',
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validationMessages: {
                  ValidationMessage.required: (error) => 'Password is Required',
                  ValidationMessage.contains: (error) => error as String,
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(Colors.blue),
                  foregroundColor: WidgetStatePropertyAll(Colors.white),
                ),
                onPressed: () {
                  if (loginFormgroup.valid) {
                    context.goNamed('home');
                  } else {
                    print(loginFormgroup.errors);
                    print('Form is invalid: ${loginFormgroup.rawValue}');
                  }
                },
                child: Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
