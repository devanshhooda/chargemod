import 'dart:convert';
import 'dart:math';

import 'package:devanshhooda/data/constants/endpoints.dart';
import 'package:devanshhooda/data/constants/preferences.dart';
import 'package:devanshhooda/data/models/user_model/user_model.dart';
import 'package:devanshhooda/data/network/network_exceptions.dart';
import 'package:devanshhooda/data/network/network_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRepository extends ChangeNotifier {
  late NetworkServices _restClient;
  late SharedPreferences _sharedPreferences;
  late UserModel userModel;

  final PageController pageController = PageController();

  HomeRepository({required this.userModel}) {
    _restClient = NetworkServices();

    _initSP();

    if (userModel.firstName == null || userModel.lastName == null) {
      _fetchUserDetails().then((userDetailsFetchedFromServer) =>
          print("userDetailsFetchedFromServer: $userDetailsFetchedFromServer"));
    }

    print("userModel: $userModel");
  }

  // -> State vars here
  bool isLoading = false;
  String? homePageError;
  int currentPageIndex = 0;

  // -> Methods here
  Future<void> _initSP() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void removeErrorPrompt() {
    homePageError = null;
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

  void scrollToPage(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    currentPageIndex = pageIndex;
    notifyListeners();
  }

  String _getRefreshToken() {
    late String refreshToken;

    if (userModel.refreshToken != null) {
      if (userModel.refreshToken is List) {
        refreshToken = userModel.refreshToken[Random().nextInt(3)];
      } else {
        refreshToken = userModel.refreshToken;
      }
    }

    return refreshToken;
  }

  Future<bool> _refreshAccessToken() async {
    try {
      final String refreshToken = _getRefreshToken();

      print("refreshToken: $refreshToken");

      var refreshAccessTokenResponse = await _restClient.post(
          Endpoints.refreshToken,
          withoutVersion: true,
          body: {"refreshToken": refreshToken},
          headers: {"Authorization": "Bearer ${this.userModel.accessToken}"});

      var data = refreshAccessTokenResponse['data'];

      final UserModel userModel = this.userModel.copyWith(
          accessToken: data["accessToken"], refreshToken: data["refreshToken"]);

      // Saving the initial user data here
      bool isUserSaved = await _sharedPreferences.setString(
          Preferences.userModel, jsonEncode(userModel.toJson()));

      if (isUserSaved == false) {
        homePageError = "Something went wrong, please try again";
        _stopLoading();
        return false;
      }

      return true;
    } on NetworkException catch (exception) {
      print("<=> Exception in refreshing access token: ${exception.message}<=>"
          "\n<=> With status code: ${exception.statusCode}");
      homePageError = exception.message;
    } catch (exception) {
      print(
          "<=> Exception in refreshing access token: ${exception.toString()}");
      homePageError = "Something went wrong, please try again";
    }

    _stopLoading();
    return false;
  }

  Future<void> getAllLocations(
      {String lat = "8.5465282",
      String long = "76.9151412",
      int page = 1,
      int limit = 10}) async {
    try {
      String getLocationsRequestUrl =
          "$lat/$long/${Endpoints.getAllLocations}?limit=$limit&page=$page";

      print("accessToken: ${userModel.accessToken}");

      await _restClient.get(getLocationsRequestUrl,
          headers: {"Authorization": "Bearer ${userModel.accessToken}"});
    } on NetworkException catch (exception) {
      print(
          "<=> Exception in fetching all locations for map: ${exception.message}<=>"
          "\n<=> With status code: ${exception.statusCode}");
      homePageError = exception.message;

      if (exception.statusCode == 401) {
        await _refreshAccessToken().then((result) => {
              if (result == true)
                getAllLocations(lat: lat, long: long, page: page, limit: limit)
            });
      }
      _startLoading();
    } catch (exception) {
      print(
          "<=> Exception in fetching all locations for map: ${exception.toString()}");
      homePageError = "Something went wrong, please try again";
    }

    _stopLoading();
  }

  Future<bool> _fetchUserDetails() async {
    _startLoading();

    try {
      print("accessToken: ${this.userModel.accessToken}");

      var userDetailsResponse = await _restClient.get(Endpoints.getUserDetails,
          headers: {"Authorization": "Bearer ${this.userModel.accessToken}"});

      var userDataMap = userDetailsResponse['data']['user'][0];

      print("userDataMap: $userDataMap");

      UserModel userModel = UserModel.fromJson(userDataMap);

      this.userModel = userModel.copyWith(
          accessToken: this.userModel.accessToken,
          isNewUser: this.userModel.isNewUser);

      // Saving the initial user data here
      bool isUserSaved = await _sharedPreferences.setString(
          Preferences.userModel, jsonEncode(userModel.toJson()));

      _stopLoading();

      return isUserSaved;
    } on NetworkException catch (exception) {
      print("<=> Exception in fetching user details: ${exception.message}<=>"
          "\n<=> With status code: ${exception.statusCode}");
      homePageError = exception.message;

      if (exception.statusCode == 401) {
        await _refreshAccessToken()
            .then((result) => {if (result == true) _fetchUserDetails()});
      }
    } catch (exception) {
      print("<=> Exception in fetching user details: ${exception.toString()}");
      homePageError = "Something went wrong, please try again";
    }

    _stopLoading();
    return false;
  }

  Future<bool> logoutUser() async {
    _startLoading();

    try {
      final String refreshToken = _getRefreshToken();

      print("accessToken: ${userModel.accessToken}");
      print("refreshToken: $refreshToken");

      await _restClient.post(Endpoints.logout,
          withoutVersion: true,
          body: {"refreshToken": refreshToken},
          headers: {"Authorization": "Bearer ${userModel.accessToken}"});

      bool isUserModelRemovedFromSP =
          await _sharedPreferences.remove(Preferences.userModel);

      _stopLoading();

      return isUserModelRemovedFromSP;
    } on NetworkException catch (exception) {
      print("<=> Exception logging out user: ${exception.message}<=>"
          "\n<=> With status code: ${exception.statusCode}");
      homePageError = exception.message;

      if (exception.statusCode == 401) {
        await _refreshAccessToken()
            .then((result) => {if (result == true) _fetchUserDetails()});
      }
    } catch (exception) {
      print("<=> Exception in logging out user: ${exception.toString()}");
      homePageError = "Something went wrong, please try again";
    }

    _stopLoading();
    return false;
  }
}
