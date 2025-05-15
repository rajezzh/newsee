import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsee/AppSamples/ReactiveForms/config/appconfig.dart';
import 'package:newsee/AppSamples/ReactiveForms/view/loginwithblocprovider.dart';
import 'package:newsee/Model/login_request.dart';
import 'package:newsee/blocs/login/login_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

void loginActionSheet(
  BuildContext context,
){

  final double screenwidth = MediaQuery.of(context).size.width;
  final double screenheight = MediaQuery.of(context).size.height;

  showCupertinoModalPopup(
    
    context: context, 
    
    builder: (BuildContext context)=> SingleChildScrollView(
      child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [const Color.fromARGB(126, 1, 1, 129),const Color.fromARGB(64, 1, 1, 129)]),
      borderRadius: BorderRadius.circular(10)
),
        padding: EdgeInsets.all(10),
        width: screenwidth * 1.0,
        height: screenheight * 0.6,
        child: LoginBlocProvide()
      ),
    )
  );
}


class LoginpageWithAC extends StatelessWidget {
  const LoginpageWithAC({super.key});

  @override
  Widget build(BuildContext context) {
    final loginFormgroup = AppConfig().loginFormgroup;
    final ValueNotifier<bool> _passwordVisibleNotifier = ValueNotifier<bool>(false);


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

          return Container(
            // padding: const EdgeInsets.only(top: 20),
            // height: double.infinity,
            // width: double.infinity,
            // decoration: BoxDecoration(
              
            // ),
            child: SingleChildScrollView(
              child: Container(
                child: ReactiveForm(
                  formGroup: loginFormgroup,
                  child: Center(
                    child: Container(
                      width: 300,
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                    
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20,top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Login Account", style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold
                                  
                                ),
                                textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ),
                          ReactiveTextField(
                            formControlName: 'username',
                            autofocus: true,
                            decoration: InputDecoration(
                              labelText: 'Username',
                              suffixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                            validationMessages: {
                              ValidationMessage.required:
                                  (error) => 'UserName is Required',
                              ValidationMessage.contains:
                                  (error) => error as String,
                            },
                          ),
                          SizedBox(height: 10.0),
                          
                         ValueListenableBuilder<bool>(
                              valueListenable: _passwordVisibleNotifier,
                              builder: (context, passwordVisible, child) {
                                return ReactiveTextField(
                                  formControlName: 'password',
                                  obscureText: !passwordVisible,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    suffixIcon: IconButton(
                                      icon: Icon(passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {

                                        _passwordVisibleNotifier.value =
                                            !passwordVisible;
                                      },
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  validationMessages: {
                                    ValidationMessage.required:
                                        (error) => 'Password is Required',
                                    ValidationMessage.contains:
                                        (error) => error as String,
                                  },
                                );
                              },
                            ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            style: const ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll<Color>(
                                Color.fromARGB(255, 2, 59, 105),
                                
                              ),
                              foregroundColor: WidgetStatePropertyAll(Colors.white),
                              minimumSize: WidgetStatePropertyAll(Size(230, 40))
                              
                            ),
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
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}