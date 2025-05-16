import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsee/AppSamples/ReactiveForms/config/appconfig.dart';
import 'package:newsee/Model/login_request.dart';
import 'package:newsee/blocs/login/login_bloc.dart';
import 'package:newsee/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginpageView extends StatelessWidget {
  const LoginpageView({super.key});

  @override
  Widget build(BuildContext context) {
    final loginFormgroup = AppConfig().loginFormgroup;

    // fakeLogin(AuthState state) {
    //   if (loginFormgroup.valid) {
    //     context.read<LoginBloc>().add(
    //       LoginFetch(
    //         loginRequest: LoginRequest(
    //           username: loginFormgroup.value['username'] as String,
    //           password: loginFormgroup.value['password'] as String,
    //         ),
    //       ),
    //     );
    //     print(state.toString());

    //     //context.goNamed('home');
    //   } else {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text('Please fill in all required fields')),
    //     );
    //   }
    // }

    login(AuthState state) {
      if (loginFormgroup.valid) {
        context.read<AuthBloc>().add(
          LoginWithAccount(
            loginRequest: LoginRequest(
              username: loginFormgroup.value['username'] as String,
              password: loginFormgroup.value['password'] as String,
            ),
          ),
        );
        print(state.toString());

        //context.goNamed('home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all required fields')),
        );
      }
    }

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        switch (state.authStatus) {
          case AuthStatus.success:
            print('LoginStatus.success...');
            context.goNamed('home');
          case AuthStatus.loading:
            print('LoginStatus.loading...');

          case AuthStatus.init:
            print('LoginStatus.init...');

          case AuthStatus.failure:
            print('LoginStatus.error...');

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Login Failed...')),
            );
        }
        ;
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final isLoading = state.authStatus == AuthStatus.loading;
          print('state.authStatus => ${state.authStatus}');
          return Container(
            padding: const EdgeInsets.only(top: 20),
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(235, 2, 34, 66),
                  const Color.fromARGB(211, 36, 12, 171),
                ],
              ),
            ),
            child: ReactiveForm(
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
                          ValidationMessage.contains:
                              (error) => error as String,
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
                          ValidationMessage.required:
                              (error) => 'Password is Required',
                          ValidationMessage.contains:
                              (error) => error as String,
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
                        onPressed:
                            isLoading
                                ? null
                                : () {
                                  //fakeLogin(state);
                                  login(state);
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
            ),
          );
        },
      ),
    );
  }
}
