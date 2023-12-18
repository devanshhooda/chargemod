import 'package:devanshhooda/modules/sign_in/core/otp_repository.dart';
import 'package:flutter/material.dart';

import 'otp_textfield.dart';

class SeparatedOtpTextfields extends StatelessWidget {
  const SeparatedOtpTextfields({super.key, required this.otpRepository});
  final OtpRepository otpRepository;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          4,
          (index) => Padding(
                padding: const EdgeInsets.all(5.0),
                child: OtpTextfield(otpRepository: otpRepository, index: index),
              )),
    );
  }
}
