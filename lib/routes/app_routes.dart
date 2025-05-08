import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsee/AppData/app_route_constants.dart';
import 'package:newsee/AppSamples/ReactiveForms/view/loginpage_view.dart';
import 'package:newsee/AppSamples/ToolBarWidget/view/toolbar_view.dart';
import 'package:newsee/Model/login_request.dart';
import 'package:newsee/blocs/camera/camera.dart';
import 'package:newsee/blocs/login/login_bloc.dart';
import 'package:newsee/pages/not_found_error.page.dart';
import 'package:newsee/pages/profile_page.dart';

final routes = GoRouter(
  initialLocation: '/login',
  
  routes: <RouteBase>[
    GoRoute(
      path: AppRouteConstants.LOGIN_PAGE['path']!,
      name: AppRouteConstants.LOGIN_PAGE['name'],
      builder:
          (context, state) => Scaffold(
            body: BlocProvider(
              create:
                  (_) => LoginBloc(
                    loginRequest: LoginRequest(username: '', password: ''),
                  ),
              child: const LoginpageView(),
            ),
          ),
    ),
    GoRoute(
      path: AppRouteConstants.HOME_PAGE['path']!,
      name: AppRouteConstants.HOME_PAGE['name'],
      builder: (context, state) => ToolbarView(),
    ),
    GoRoute(
      path: AppRouteConstants.PROFILE_PAGE['path']!,
      name: AppRouteConstants.PROFILE_PAGE['name'],
      builder: (context, state) => ProfilePage(),
    ),
    GoRoute(
      path: AppRouteConstants.CAMERA_PAGE['path']!,
      name: AppRouteConstants.CAMERA_PAGE['name'],
      builder: (context, state) => Camera(),
    ),
  ],
  redirect: (context, state) {
    print(state.fullPath);
    if (state.fullPath == '/') {
      return '/login';
    } else {
      return null;
    }
  },
  errorBuilder: (context, state) => NotFoundErrorPage(),
);
