import 'dart:convert';

import 'package:newsee/feature/auth/domain/model/user_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// parse a sharedpreference key and return the Object
///
class SharedPreferenceHandler<T> {
  SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
  String key;
  Future<T>? obj;
  // factory construtor will be invoked to get object from shared preference

  SharedPreferenceHandler._({required this.key});
  factory SharedPreferenceHandler.getFromKey(String key) =>
      SharedPreferenceHandler._(key: key);

  Future<T> setObj() async {
    //    String? userDetailJson = await asyncPrefs.getString('userdetails');
    //UserDetails userdetails = UserDetails.fromJson(jsonDecode(userDetailJson!));

    String? jsonString = await asyncPrefs.getString(key);
    if (T is UserDetails) {
      return Future.value(UserDetails.fromJson(jsonDecode(jsonString!)) as T);
    } else {
      return Future.value(
        UserDetails(
              LPuserID: '',
              UserName: '',
              Orgscode: '',
              OrgLevel: '',
              OrgName: '',
            )
            as T,
      );
    }
  }
}
