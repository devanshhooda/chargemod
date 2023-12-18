import 'package:devanshhooda/modules/sign_in/core/otp_repository.dart';
import 'package:flutter/material.dart';

class OtpTextfield extends StatelessWidget {
  const OtpTextfield(
      {super.key, required this.otpRepository, required this.index});
  final int index;
  final OtpRepository otpRepository;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      width: 65,
      child: TextField(
        controller: otpRepository.otpControllers[index],
        keyboardType: TextInputType.number,
        maxLength: 1,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            height: 1.25,
            fontWeight: FontWeight.bold),
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
          counterText: "",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        onChanged: (value) {
          if (otpRepository.otpError != null) {
            otpRepository.removeErrorPrompt();
          }

          if (value.length == 1 && index < 3) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
