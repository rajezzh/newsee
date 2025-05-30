import 'package:flutter/material.dart';
import 'package:newsee/AppSamples/RouterApp/routerapp.dart';
import 'package:newsee/AppSamples/ToolBarWidget/toolbar.dart';
import 'package:newsee/Utils/injectiondependency.dart';
import 'package:newsee/app.dart';
import 'package:newsee/widgets/counter.dart';
import 'package:newsee/widgets/news.dart';
import 'package:provider/provider.dart';

void main() {
  // runApp(MyApp()) // Default MyApp()
  // runApp(Counter()); // load CounterApp
  // runApp(App()); // timerApp
  // runApp(ToolBarSample()); // Toolbar App
  //runApp(LoginApp()); // Login Form App
  // dependencyInjection();
  runApp(RouterApp()); // GoRouter Sample App
}
