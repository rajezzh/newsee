import 'package:flutter/material.dart';
import 'package:newsee/AppData/globalconfig.dart';

class ToolbarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          Globalconfig.isInitialRoute
              ? null
              : AppBar(title: Text('Toolbar Sample')),
      drawer:
          Globalconfig.isInitialRoute ? null : NavigationDrawer(children: []),
      body: Center(
        child: Text("....Login Page....", style: TextStyle(fontSize: 24.0)),
      ),
    );
  }
}
