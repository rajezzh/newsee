import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Column(
          children: [
            Center(
              child: Container(
                width: 200,
                height: 200,
                color: Colors.grey[300],
                child: const Icon(Icons.person, size: 50),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                 context.goNamed("camera");
              }, 
              child: Text("Captrue Image")
            )
          ],
        ),
      ),
    );
  }
}