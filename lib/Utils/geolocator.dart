import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:newsee/Model/loader.dart';

Future<Position> getLocation(BuildContext context) async{
  try {
    LocationPermission permissionstatus;
    Position gelocationdata;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const LoaderView(),
    );

    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permissionstatus = await Geolocator.checkPermission();

    if (permissionstatus == LocationPermission.denied) {
      await Geolocator.requestPermission();
      if (permissionstatus == LocationPermission.denied) {
        throw Exception('Location services are disabled.');
      }
    }

    if (permissionstatus == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied, we cannot request permissions.');
    } 

    gelocationdata = await Geolocator.getCurrentPosition();
    print("gelocationdata: $gelocationdata");
    
    return gelocationdata;
  } catch (error) {
    rethrow;
  } finally {
    Navigator.of(context, rootNavigator: true).pop(); // Dismiss the loader
  }
}

