import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsee/AppSamples/ReactiveForms/view/login-with-account.dart';
import 'package:newsee/Model/login_request.dart';
import 'package:newsee/blocs/login/login_bloc.dart';

class LoginBlocProvide extends StatelessWidget {
  const LoginBlocProvide ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: BlocProvider(
              create:
                  (_) => LoginBloc(
                    loginRequest: LoginRequest(username: '', password: ''),
                  ),
              child: 
              LoginpageWithAC(),
            ),
          );
  }
}