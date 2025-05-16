import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsee/AppSamples/ReactiveForms/config/appconfig.dart';
import 'package:newsee/Model/login_request.dart';
import 'package:newsee/Utils/local_biometric.dart';
import 'package:newsee/blocs/login/login_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginpageView extends StatelessWidget {
  const LoginpageView({super.key});

  void loginwithbiometric(BuildContext context) async{
    try {
      final biostatus = await biometricAuthentication();
      if (biostatus.status == false) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(biostatus.message)),
          );
        }
      } else {
        if (context.mounted) {
          context.goNamed('home');
        }
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginFormgroup = AppConfig().loginFormgroup;

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        switch (state.loginStatus) {
          case LoginStatus.success:
            print('LoginStatus.success...');
            context.goNamed('home');
          case LoginStatus.fetch:
          case LoginStatus.init:
            print('LoginStatus.init...');

          case LoginStatus.error:
            print('LoginStatus.error...');

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Login failed: Invalid credentials')),
            );
        }
        ;
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          final isLoading = state.loginStatus == LoginStatus.fetch;
          final isHidden = state.isPasswordHidden;
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
                        ValidationMessage.required:
                            (error) => 'UserName is Required',
                        ValidationMessage.contains: (error) => error as String,
                      },
                    ),
                    SizedBox(height: 10.0),
                    ReactiveTextField(
                      formControlName: 'password',
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {context.read<LoginBloc>().add(LoginSecurePassword());}, 
                          icon: Icon(isHidden? Icons.visibility_off : Icons.visibility)
                        ),
                        labelText: 'Password',
                        border: OutlineInputBorder(),

                      ),
                      obscureText: isHidden,
                      validationMessages: {
                        ValidationMessage.required:
                            (error) => 'Password is Required',
                        ValidationMessage.contains: (error) => error as String,
                      },
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll<Color>(
                          Colors.blue,
                        ),
                        foregroundColor: WidgetStatePropertyAll(Colors.white),
                      ),
                      // onPressed: () {loginwithbiometric(context);},
                      // child: Text("Login"),
                      onPressed:
                          isLoading
                              ? null
                              : () {
                                if (loginFormgroup.valid) {
                                  context.read<LoginBloc>().add(
                                    LoginFetch(
                                      loginRequest: LoginRequest(
                                        username:
                                            loginFormgroup.value['username']
                                                as String,
                                        password:
                                            loginFormgroup.value['password']
                                                as String,
                                      ),
                                    ),
                                  );
                                  print(state.toString());

                                  //context.goNamed('home');
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Please fill in all required fields',
                                      ),
                                    ),
                                  );
                                }
                              },
                      child:
                          isLoading
                              ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.0,
                                ),
                              )
                              : const Text("Login"),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
