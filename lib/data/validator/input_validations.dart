class InputValidations {
  final RegExp _emailRegex = RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\$");

  bool isValidPhoneNumber({required String phoneNumber}) {
    try {
      // We can use regex too but for MVP this logic is enough as per my understanding
      return (phoneNumber.length == 10 && int.tryParse(phoneNumber) != null);
    } catch (exception) {
      print("Exception in validating $phoneNumber: ${exception.toString()}");
    }

    return false;
  }

  // bool isInvalidOtp({required List<String> otpTexts}) => otpTexts
  //     .any((otpText) => (otpText.isEmpty || int.tryParse(otpText) == null));

  bool isValidOtp({required String otpText}) =>
      (otpText.isNotEmpty && int.tryParse(otpText) != null);

  bool isInvalidValidEmail({required String emailAdress}) =>
      (emailAdress.isEmpty || _emailRegex.hasMatch(emailAdress) == false);
}
