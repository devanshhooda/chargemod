import 'dart:async';

import 'package:country_picker/country_picker.dart';
import 'package:devanshhooda/data/constants/endpoints.dart';
import 'package:devanshhooda/data/network/network_exceptions.dart';
import 'package:devanshhooda/data/network/network_services.dart';
import 'package:devanshhooda/data/validator/input_validations.dart';
import 'package:flutter/material.dart';

class LoginRepository with ChangeNotifier {
  late NetworkServices _restClient;
  late InputValidations _inputValidations;
  late String phoneNumber;

  late TextEditingController phoneNumberController;

  LoginRepository() {
    _restClient = NetworkServices();
    _inputValidations = InputValidations();

    selectedCountry = Country.parse("IN");
    phoneNumberController = TextEditingController();
  }

  // -> State vars here
  late Country selectedCountry;
  bool isLoading = false;
  String? phoneNumberError, otpError;

  // -> Methods here

  void changeSelectedCountry({required Country selectedCountry}) {
    this.selectedCountry = selectedCountry;
    removeErrorPrompt();
    notifyListeners();
  }

  void removeErrorPrompt() {
    phoneNumberError = null;
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

  Future<bool> signIn() async {
    _startLoading();

    phoneNumber = "${selectedCountry.phoneCode}${phoneNumberController.text}";

    try {
      bool isValidPhoneNumber = _inputValidations.isValidPhoneNumber(
          phoneNumber: phoneNumberController.text);

      if (isValidPhoneNumber == false) {
        phoneNumberError = "Please enter a valid phone number !";
        _stopLoading();
        return false;
      }

      var signInResponse = await _restClient
          .post(Endpoints.signIn, body: {"mobile": phoneNumber});

      _stopLoading();

      return (signInResponse['feasibilityStatus'] == true);
    } on NetworkException catch (exception) {
      print(
          "<=> Exception in sending OTP on $phoneNumber: ${exception.message}<=>"
          "\n<=> With status code: ${exception.statusCode}");
      phoneNumberError = exception.message;
    } catch (exception) {
      print(
          "<=> Exception in sending OTP on $phoneNumber: ${exception.toString()}");
      phoneNumberError = "Something went wrong, please try again";
    }

    _stopLoading();
    return false;
  }
}
