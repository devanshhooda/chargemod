import 'package:devanshhooda/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 60),
      child: Column(
        children: [
          LinearProgressIndicator(minHeight: 5, color: AppColors.primaryColor),
          SizedBox(height: 5),
          Text(
            'Connecting to chargeMOD',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xFFEBEBEB),
                fontSize: 11,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                letterSpacing: 1),
          )
        ],
      ),
    );
  }
}
