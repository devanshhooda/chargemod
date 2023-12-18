import 'package:devanshhooda/utils/app_colors.dart';
import 'package:flutter/material.dart';

class LoadingOverlayScreen extends StatelessWidget {
  const LoadingOverlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white54,
      child: const Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
