import 'dart:async';
import 'dart:convert';

import 'package:devanshhooda/data/constants/endpoints.dart';
import 'package:devanshhooda/data/constants/preferences.dart';
import 'package:devanshhooda/data/models/user_model.dart';
import 'package:devanshhooda/data/network/network_exceptions.dart';
import 'package:devanshhooda/data/network/network_services.dart';
import 'package:devanshhooda/data/validator/input_validations.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpRepository extends ChangeNotifier {
  late NetworkServices _restClient;
  late InputValidations _inputValidations;
  late SharedPreferences _sharedPreferences;
  Timer? _timer;

  late String phoneNumber;
  late List<TextEditingController> otpControllers;

  OtpRepository({required this.phoneNumber}) {
    _restClient = NetworkServices();
    _inputValidations = InputValidations();
    otpControllers = List.generate(4, (index) => TextEditingController());

    _initSP();
  }

  // -> State vars here
  bool isLoading = false;
  String? otpError;
  bool isTimerActive = false;
  int secondsRemaining = 30;

  // -> Methods here

  void removeErrorPrompt() {
    otpError = null;
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

  Future<UserModel?> verifyOtp() async {
    if (_timer != null && _timer!.isActive) {
      _timer?.cancel();
      isTimerActive = false;
      secondsRemaining = 30;
    }
    _startLoading();

    try {
      print("inside verifyOtp");
      String otpText = "";

      for (var otpController in otpControllers) {
        otpText += otpController.text;

        bool isValidOtp = _inputValidations.isValidOtp(otpText: otpText);

        if (isValidOtp == false) {
          otpError = "Please enter a valid OTP !";
          _stopLoading();
          return null;
        }
      }

      print("otp:" + otpText);

      var verifyOtpResponse = await _restClient.post(Endpoints.verifyOTP,
          body: {"mobile": phoneNumber, "otp": otpText});

      if (verifyOtpResponse['message'] == 'error') {
        otpError = "Something went wrong, please try again";
        _stopLoading();
        return null;
      }

      final userData = verifyOtpResponse['data'];
      final UserModel userModel =
          UserModel.fromJson(userData).copyWith(mobile: phoneNumber);

      // Saving the initial user data here
      bool isUserSaved = await _sharedPreferences.setString(
          Preferences.userModel, jsonEncode(userModel.toJson()));

      if (isUserSaved == false) {
        otpError = "Something went wrong, please try again";
        _stopLoading();
        return null;
      }

      _stopLoading();

      return userModel;
    } on NetworkException catch (exception) {
      print("<=> Exception in verifying OTP: ${exception.message}<=>"
          "\n<=> With status code: ${exception.statusCode}");
      otpError = exception.message;
    } catch (exception) {
      print("<=> Exception in verifying OTP: ${exception.toString()}");
      otpError = "Something went wrong, please try again";
    }

    _stopLoading();
    return null;
  }

  Future<void> resendOtp({String type = "text"}) async {
    try {
      print('inside resendOtp for no: $phoneNumber');
      var resendOtpResponse = await _restClient.post(Endpoints.resendOTP,
          body: {"mobile": phoneNumber, "type": type});

      if (resendOtpResponse['feasibilityStatus'] == true) {
        secondsRemaining = 60;
        isTimerActive = true;
        _startResendCodeTimer();
      } else {
        otpError = "OTP resending failed, please try again";
      }
    } on NetworkException catch (exception) {
      print("<=> Exception in re-sending OTP: ${exception.message}<=>"
          "\n<=> With status code: ${exception.statusCode}");
      otpError = exception.message;
    } catch (exception) {
      print("<=> Exception in re-sending OTP: ${exception.toString()}");
      otpError = "Something went wrong, please try again";
    }

    notifyListeners();
  }

  void _startResendCodeTimer() {
    Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        _timer = timer;

        if (secondsRemaining == 0) {
          isTimerActive = false;
          _timer?.cancel();
        } else {
          secondsRemaining--;
        }

        notifyListeners();
      },
    );
  }
}
