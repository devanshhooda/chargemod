import 'package:devanshhooda/modules/sign_in/core/login_repository.dart';
import 'package:devanshhooda/modules/sign_in/views/ui/login_screen.dart';
import 'package:devanshhooda/modules/splash/core/onboarding_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FloatingNavigationButton extends StatelessWidget {
  const FloatingNavigationButton(
      {super.key, required this.isForward, required this.onboardingRepository});
  final bool isForward;
  final OnboardingRepository onboardingRepository;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        heroTag: isForward ? "Forward" : "Backward",
        onPressed: () {
          if (isForward) {
            // Navigate to Login flow if its last screen
            if (onboardingRepository.currentPageIndex ==
                (onboardingRepository.totalPagesCount - 1)) {
              Navigator.of(context).pushAndRemoveUntil(
                  CupertinoPageRoute(
                      builder: (context) =>
                          ChangeNotifierProvider<LoginRepository>(
                              create: (context) => LoginRepository(),
                              child: const LoginScreen())),
                  (route) => false);
            } else {
              // Navigate to next screen
              onboardingRepository
                  .scrollToPage(onboardingRepository.currentPageIndex + 1);
            }
          } else {
            // Navigate back to previous screen
            onboardingRepository
                .scrollToPage(onboardingRepository.currentPageIndex - 1);
          }
        },
        // foregroundColor: Colors.orange,
        backgroundColor: Colors.deepOrange[400],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        child: Icon(
          isForward ? Icons.arrow_forward_ios : Icons.arrow_back_ios_new,
          color: Colors.white,
        ));
  }
}
