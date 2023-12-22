import 'dart:convert';

import 'package:devanshhooda/data/constants/endpoints.dart';
import 'package:devanshhooda/data/constants/preferences.dart';
import 'package:devanshhooda/data/models/user_model/user_model.dart';
import 'package:devanshhooda/data/network/network_exceptions.dart';
import 'package:devanshhooda/data/network/network_services.dart';
import 'package:devanshhooda/data/validator/input_validations.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileRepository with ChangeNotifier {
  late NetworkServices _restClient;
  late InputValidations _inputValidations;
  late SharedPreferences _sharedPreferences;

  late String phoneNumber;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;

  UserProfileRepository({required this.phoneNumber}) {
    _restClient = NetworkServices();
    _inputValidations = InputValidations();

    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();

    _initSP();
  }

  // -> State vars here
  bool isLoading = false;
  String? updateUserError;

  // -> Methods here

  void removeErrorPrompts() {
    updateUserError = null;
    notifyListeners();
  }

  void _startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void _stopLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future<void> _initSP() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<UserModel?> updateUserProfile() async {
    _startLoading();
    bool isInvalidData = false;

    try {
      if (firstNameController.text.isEmpty) {
        updateUserError = "Please enter your First Name";
        isInvalidData = true;
      } else if (lastNameController.text.isEmpty) {
        updateUserError = "Please enter your Last Name";
        isInvalidData = true;
      } else if (_inputValidations.isInvalidValidEmail(
          emailAdress: emailController.text)) {
        updateUserError = "Please enter a valid E-mail";
        isInvalidData = true;
      }

      if (isInvalidData) {
        _stopLoading();
        return null;
      }

      var updateProfileResponse =
          await _restClient.post(Endpoints.registerUser, body: {
        "mobile": phoneNumber,
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "email": emailController.text
      });

      final String? userModelString =
          _sharedPreferences.getString(Preferences.userModel);

      if (userModelString == null) {
        updateUserError = "Something went wrong, please try again";
        _stopLoading();
        return null;
      }
      final Map<String, dynamic> userModelMap = jsonDecode(userModelString);

      final UserModel userModelFromSP = UserModel.fromJson(userModelMap);
      final UserModel userModelFromAPI =
          UserModel.fromJson(updateProfileResponse);

      final UserModel userModel = userModelFromAPI.copyWith(
          accessToken: userModelFromSP.accessToken,
          isNewUser: userModelFromSP.isNewUser);

      // Saving the initial user data here
      bool isUserSaved = await _sharedPreferences.setString(
          Preferences.userModel, jsonEncode(userModel.toJson()));

      if (isUserSaved == false) {
        updateUserError = "Something went wrong, please try again";
        _stopLoading();
        return null;
      }

      _stopLoading();

      return userModel;
    } on NetworkException catch (exception) {
      print(
          "<=> Exception in updating profile for $phoneNumber: ${exception.message}<=>"
          "\n<=> With status code: ${exception.statusCode}");
      updateUserError = exception.message;
    } catch (exception) {
      print(
          "<=> Exception in updating profile for $phoneNumber: ${exception.toString()}");
      updateUserError = "Something went wrong, please try again";
    }

    _stopLoading();
    return null;
  }
}
