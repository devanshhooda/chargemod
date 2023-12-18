import 'package:flutter/cupertino.dart';

class OnBoardingFooter extends StatelessWidget {
  const OnBoardingFooter({super.key, required this.footerText});
  final String footerText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Text(
        footerText,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 15,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
