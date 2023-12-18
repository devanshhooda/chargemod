import 'package:devanshhooda/utils/app_colors.dart';
import 'package:flutter/material.dart';

class OnBoardingHeader extends StatelessWidget {
  const OnBoardingHeader(
      {super.key,
      required this.headerText,
      required this.middleText,
      required this.footerText});
  final String headerText, middleText, footerText;
  static const String _fontFamily = "Poppins";

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          headerText,
          style: const TextStyle(
              fontFamily: _fontFamily,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              fontSize: 15),
        ),
        const SizedBox(height: 1),
        Text(
          middleText,
          style: const TextStyle(
              fontFamily: _fontFamily,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
              height: 1,
              fontSize: 32),
        ),
        const SizedBox(height: 1),
        Text(footerText,
            style: const TextStyle(
                fontFamily: _fontFamily,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
                fontSize: 32,
                height: 1,
                color: AppColors.primaryColor)),
      ],
    );
  }
}
