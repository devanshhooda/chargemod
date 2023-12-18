import 'package:devanshhooda/modules/sign_in/core/otp_repository.dart';
import 'package:devanshhooda/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ResendOtp extends StatelessWidget {
  const ResendOtp({super.key, required this.otpRepository});
  final OtpRepository otpRepository;

  @override
  Widget build(BuildContext context) {
    if (otpRepository.isTimerActive) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Re-send code in ', style: TextStyle(color: Colors.white)),
          Text(
            otpRepository.secondsRemaining.toString(),
            style: const TextStyle(color: AppColors.primaryColor),
          )
        ],
      );
    } else {
      return TextButton(
          onPressed: () async {
            await otpRepository.resendOtp();
          },
          child: const Text(
            'Resent OTP',
            style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 17,
                fontWeight: FontWeight.w400),
          ));
    }
  }
}
