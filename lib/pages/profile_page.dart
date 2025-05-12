import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  Uint8List? profilebytes;
  @override 
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;  

    return Scaffold(
      body: SizedBox(
        child: Column(
          children: [
            SizedBox(
              height: (screenheight * 0.1),
            ),
            Center(
              child: profilebytes != null ? 
                Image.memory(
                  profilebytes!,
                  width: screenwidth * 0.8,
                  height: screenheight * 0.6,
                ) : 
                Container(
                  width: screenwidth * 0.8,
                  height: screenheight * 0.6,
                  color: Colors.grey[300],
                  child: const Icon(Icons.person, size: 50),
                ),
            ),
            SizedBox(
              height: (screenheight * 0.1)
            ),
            SizedBox(
              height: (screenheight * 0.2),
              child: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    final getprofileData =  await context.pushNamed<Uint8List>("camera");
                    if (getprofileData != null) {
                      setState(() {
                        profilebytes = getprofileData;
                      });
                    }
                    print("getprofileData $getprofileData");
                  }, 
                  child: Text("Captrue Image")
                ),
              ),
            )
            
          ],
        ),
      ),
    );
  }
}