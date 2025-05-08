import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsee/AppSamples/ReactiveForms/config/appconfig.dart';
import 'package:newsee/Model/login_request.dart';
import 'package:newsee/blocs/login/login_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';


class LoginpageView extends StatelessWidget {
  const LoginpageView({super.key});

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

          return Container(
            padding: const EdgeInsets.only(top: 0,right: 0,left: 0),
  
            // color: const Color.fromARGB(255, 4, 72, 190),
            decoration:BoxDecoration(
              
              image:DecorationImage(image: AssetImage(
                "images/log.png",
                ),
                 fit: BoxFit.none, 
                  alignment: Alignment.topCenter               

                
                
                )
            ),
            

            //       decoration: BoxDecoration(
            //         gradient: LinearGradient(
            //     colors: [
            //       const Color.fromARGB(235, 2, 34, 66),
            //       Color.fromARGB(211, 36, 12, 171),
            //     ],
            //   ),
            // ),
            child: SingleChildScrollView(
              child: ReactiveForm(
                formGroup: loginFormgroup,
                child: Column(

                  children: [
                    // const Padding(
                    //   padding: EdgeInsets.only(left: 20),
                    //   child: Text(
                    //     'Welcome!! ',
                    //     style: TextStyle(
                    //       color: Color.fromARGB(255, 137, 142, 162),
                    //       fontSize: 40.0,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),

                    SizedBox(height:150),
              
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        padding: const EdgeInsets.only(
                          top: 50,
                          left: 20,
                          right: 20,
                          bottom: 20,
                        ),
                        width: MediaQuery.of(context).size.width,
                                    
                        // width:500,
                        // height:300,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          boxShadow: [
                       BoxShadow(
                            color:Colors.grey,
                            //  spreadRadius: 2,
                             blurRadius: 10,
                             offset: Offset(0, 3),
                               ),
                           ],
                        ),
                                    
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                                    
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.only(left: 20, top: 10),
                              child: Text(
                                'Login Account',
                                style: TextStyle(
                                  color: Color.fromARGB(200, 6, 4, 4),
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(height: 40.0),
                                    
                            ReactiveTextField(
                              formControlName: 'username',
                              autofocus: true,
                              decoration: InputDecoration(
                                labelText: 'Username',
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validationMessages: {
                                ValidationMessage.required:
                                    (error) => 'UserName is Required',
                                ValidationMessage.contains:
                                    (error) => error as String,
                              },
                            ),
                            SizedBox(height: 40.0),
                            ReactiveTextField(
                              formControlName: 'password',
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: Icon(Icons.lock),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              obscureText: true,
                              validationMessages: {
                                ValidationMessage.required:
                                    (error) => 'Password is Required',
                                ValidationMessage.contains:
                                    (error) => error as String,
                              },
                            ),
                            SizedBox(height: 40),
                            Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll<Color>(
                                    Color.fromARGB(255, 0, 35, 150),
                                  ),
                                  foregroundColor: WidgetStatePropertyAll(
                                    Colors.white,
                                  ),
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
                                                      loginFormgroup
                                                              .value['username']
                                                          as String,
                                                  password:
                                                      loginFormgroup
                                                              .value['password']
                                                          as String,
                                                ),
                                              ),
                                            );
                                            print(state.toString());
                                    
                                            //context.goNamed('home');
                                          } else {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
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
                            ),
                                    
                            // SizedBox(height: 150),
                            Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: Center(
                                child: Text(
                                  'Register Account',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromARGB(255, 5, 109, 178),
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
