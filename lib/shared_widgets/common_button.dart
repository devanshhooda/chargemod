import 'package:devanshhooda/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonButton extends StatelessWidget {
  const CommonButton(
      {super.key, required this.buttonText, required this.onPressed});
  final String buttonText;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        height: 50,
        minWidth: 300,
        onPressed: () {
          onPressed();

          // Dismissing any open keyboards
          SystemChannels.textInput.invokeMethod('TextInput.hide');
        },
        color: AppColors.primaryColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.5)),
        child: Text(
          buttonText,
          style: const TextStyle(
              letterSpacing: 1, fontSize: 20, fontWeight: FontWeight.w400),
        ));
  }
}
