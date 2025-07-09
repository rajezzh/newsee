  import 'dart:convert';

import 'package:newsee/feature/auth/domain/model/user_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<UserDetails?> loadUser() async {
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    String? getString = await asyncPrefs.getString('userdetails');
    UserDetails userdetails = UserDetails.fromJson(jsonDecode(getString!)); 
    return userdetails;
  }
