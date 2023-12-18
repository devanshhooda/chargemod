import 'package:devanshhooda/modules/sign_in/core/login_repository.dart';
import 'package:devanshhooda/modules/sign_in/views/ui/login_screen.dart';
import 'package:devanshhooda/modules/splash/core/onboarding_repository.dart';
import 'package:devanshhooda/modules/splash/views/ui/onboarding_screen_1.dart';
import 'package:devanshhooda/modules/splash/views/ui/onboarding_screen_2.dart';
import 'package:devanshhooda/modules/splash/views/ui/onboarding_screen_3.dart';
import 'package:devanshhooda/modules/splash/views/widets/dot_indicator.dart';
import 'package:devanshhooda/modules/splash/views/widets/floating_navigation_button.dart';
import 'package:devanshhooda/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const List _onBoardingScreens = [
    OnBoardingScreen1(),
    OnBoardingScreen2(),
    OnBoardingScreen3(),
  ];

  @override
  Widget build(BuildContext context) {
    final OnboardingRepository onboardingRepository =
        Provider.of<OnboardingRepository>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundAppColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 10),
            child: TextButton(
                onPressed: () {
                  // Navigate to Login flow if its last screen
                  Navigator.of(context).pushAndRemoveUntil(
                      CupertinoPageRoute(
                          builder: (context) =>
                              ChangeNotifierProvider<LoginRepository>(
                                  create: (context) => LoginRepository(),
                                  child: const LoginScreen())),
                      (route) => false);
                },
                child: const Text(
                  "SKIP",
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
      backgroundColor: AppColors.backgroundAppColor,
      body: PageView.builder(
          itemCount: _onBoardingScreens.length,
          controller: onboardingRepository.pageController,
          onPageChanged: onboardingRepository.scrollToPage,
          itemBuilder: (context, index) => _onBoardingScreens[index]),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(width: 1),

          // Backward button
          if (onboardingRepository.currentPageIndex != 0)
            FloatingNavigationButton(
                isForward: false, onboardingRepository: onboardingRepository)
          else
            const SizedBox(width: 55),

          SizedBox(
            height: 100,
            width: 100,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: onboardingRepository.totalPagesCount,
                itemBuilder: (context, index) => DotIndicator(
                    isActive:
                        (index == onboardingRepository.currentPageIndex))),
          ),

          // Forward button
          FloatingNavigationButton(
              isForward: true, onboardingRepository: onboardingRepository),
        ],
      ),
    );
  }
}
