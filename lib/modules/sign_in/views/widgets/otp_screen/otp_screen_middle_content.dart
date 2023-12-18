import 'package:devanshhooda/modules/sign_in/core/otp_repository.dart';
import 'package:devanshhooda/shared_widgets/error_box.dart';
import 'package:flutter/material.dart';

import 'resend_otp_widget.dart';
import 'separated_otp_textfields.dart';

class OtpMiddleContent extends StatelessWidget {
  const OtpMiddleContent({super.key, required this.otpRepository});
  final OtpRepository otpRepository;

  @override
  Widget build(BuildContext context) {
    final String message =
        "We've send you the verification code on +${otpRepository.phoneNumber}";

    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontFamily: 'ABeeZee',
                fontWeight: FontWeight.w400,
              ),
            )),

        const SizedBox(height: 10),

        // OTP text field
        SeparatedOtpTextfields(otpRepository: otpRepository),

        const SizedBox(height: 5),

        // Resend OTP widget here
        ResendOtp(otpRepository: otpRepository),

        const SizedBox(height: 20),

        (otpRepository.otpError) != null
            ? ErrorBox(errorMessage: otpRepository.otpError!)
            : const SizedBox()
      ],
    );
  }
}
