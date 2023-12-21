import 'dart:async';
import 'dart:convert';

import 'package:devanshhooda/data/constants/preferences.dart';
import 'package:devanshhooda/data/models/user_model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashRepository {
  SharedPreferences? _sharedPreferences;
  UserModel? userModel;

  Future<void> _initSP() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  String? get _getUserModel =>
      _sharedPreferences?.getString(Preferences.userModel);

  Future<UserModel?> fetchUserModel() async {
    await _initSP();

    String? userModelString = _getUserModel;
    // print("userModelString: $userModelString");

    if (userModelString == null) {
      return null;
    }

    Map<String, dynamic> userModelMap = jsonDecode(userModelString);

    // print("userModelMap: $userModelMap");

    return UserModel.fromJson(userModelMap);
  }
}
