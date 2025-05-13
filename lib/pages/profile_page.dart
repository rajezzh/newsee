import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:newsee/Utils/geolocator.dart';
import 'package:biometric_signature/biometric_signature.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  Uint8List? profilebytes;
  Position? geoPosition;
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
            Listener(
              child: geoPosition != null ? Container(
                padding: EdgeInsets.fromLTRB(screenwidth * 0.1, 5, screenwidth * 0.1, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.amber
                      ),
                      child: Row(
                        children: [
                          Text("lat: "),
                          Text((geoPosition?.latitude).toString(), style: TextStyle(backgroundColor: Colors.white))
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.amber
                      ),
                      child: Row(
                        children: [
                          Text("long: "),
                          Text((geoPosition?.longitude).toString(), style: TextStyle(backgroundColor: Colors.white))
                        ],
                      ),
                    )
                  ],
                ),
                
              ) : const SizedBox.shrink()
            ),
            SizedBox(
              height: (screenheight * 0.2),
              child: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    final curposition = await getLocation(context);
                    print("curposition: $curposition");
                    final getprofileData =  await context.pushNamed<Uint8List>("camera");
                    if (getprofileData != null) {
                      setState(() {
                        profilebytes = getprofileData;
                        geoPosition = curposition;
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