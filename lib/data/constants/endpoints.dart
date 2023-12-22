class Endpoints {
  Endpoints._();

  static const String _baseUrl =
      "https://as-uat.console.chargemod.com/temporary/sde1flutterATSR";
  static const String _organisationId = "64941897fdb322dbf94ad2b8";
  static const String _projectId = "6494141957d29409895704d2";
  static const String _appVersion = "1.0.0";

  // base url
  static const String baseUrl =
      "$_baseUrl/$_organisationId/$_projectId/$_appVersion";

  static const String baseUrlWithoutAppVersion =
      "$_baseUrl/$_organisationId/$_projectId";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  // booking endpoints
  static const String signIn = "/signIn";
  static const String verifyOTP = "/verify";
  static const String resendOTP = "/resend";
  static const String registerUser = "/register";
  static const String refreshToken = "/refresh";
  static const String getUserDetails = "/get-customer";
  static const String logout = "/logout";
  static const String getAllLocations = "/all-locations";
}
