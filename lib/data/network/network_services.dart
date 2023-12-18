import 'dart:convert';

import 'package:http/http.dart' as _httpService;

import '../constants/endpoints.dart';
import 'network_exceptions.dart';

class NetworkServices {
  final JsonDecoder _decoder = const JsonDecoder();

  // Get:-----------------------------------------------------------------------
  Future<dynamic> get(String path, {Map<String, String>? headers}) {
    return _httpService
        .get(Uri.parse("${Endpoints.baseUrl}$path"), headers: headers)
        .then(_createResponse);
  }

  // Post:----------------------------------------------------------------------
  Future<dynamic> post(String path,
      {Map<String, String>? headers,
      body,
      encoding,
      bool withoutVersion = false}) {
    return _httpService
        .post(
          Uri.parse(
              "${withoutVersion ? Endpoints.baseUrlWithoutAppVersion : Endpoints.baseUrl}$path"),
          body: body,
          headers: headers,
          encoding: encoding,
        )
        .then(_createResponse);
  }

  // Put:----------------------------------------------------------------------
  Future<dynamic> put(String path,
      {Map<String, String>? headers, body, encoding}) {
    return _httpService
        .put(
          Uri.parse("${Endpoints.baseUrl}$path"),
          body: body,
          headers: headers,
          encoding: encoding,
        )
        .then(_createResponse);
  }

  // Delete:----------------------------------------------------------------------
  Future<dynamic> delete(String path,
      {Map<String, String>? headers, body, encoding}) {
    return _httpService
        .delete(
          Uri.parse("${Endpoints.baseUrl}$path"),
          body: body,
          headers: headers,
          encoding: encoding,
        )
        .then(_createResponse);
  }

  // Response:------------------------------------------------------------------
  dynamic _createResponse(_httpService.Response response) {
    final String res = response.body;
    final int statusCode = response.statusCode;

    print("API Res Code: $statusCode");
    print("API Res: $res");

    if (statusCode < 200 || statusCode > 400) {
      throw NetworkException(
          message: 'Error fetching data from server', statusCode: statusCode);
    }

    return _decoder.convert(res);
  }
}
