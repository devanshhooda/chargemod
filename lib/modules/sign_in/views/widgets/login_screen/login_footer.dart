import 'package:devanshhooda/utils/app_colors.dart';
import 'package:flutter/material.dart';

class LoginPageFooter extends StatelessWidget {
  const LoginPageFooter({super.key});

  static const TextStyle _clickableLinkTextStyle =
      TextStyle(color: AppColors.primaryColor);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('By Continuing you agree to our'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              child: Text(
                'Terms & Conditions',
                style: _clickableLinkTextStyle,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text('and'),
            SizedBox(
              width: 5,
            ),
            InkWell(
              child: Text(
                'Privacy Policy',
                style: _clickableLinkTextStyle,
              ),
            ),
          ],
        )
      ],
    );
  }
}
