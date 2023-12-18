import 'package:devanshhooda/modules/home/core/home_repository.dart';
import 'package:devanshhooda/modules/home/views/ui/home_screen.dart';
import 'package:devanshhooda/modules/splash/core/onboarding_repository.dart';
import 'package:devanshhooda/modules/splash/core/splash_repository.dart';
import 'package:devanshhooda/modules/splash/views/ui/onboarding_main_screen.dart';
import 'package:devanshhooda/modules/splash/views/widets/progress_bar.dart';
import 'package:devanshhooda/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final SplashRepository splashRepository = SplashRepository();

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 4)).then((_) => splashRepository
        .fetchUserModel()
        .then((userModel) => Navigator.of(context).pushAndRemoveUntil(
                CupertinoPageRoute(builder: (context) {
              if (userModel == null) {
                // Navigating to Onboarding flow
                return ChangeNotifierProvider<OnboardingRepository>(
                    create: (context) => OnboardingRepository(),
                    child: const OnboardingScreen());
              } else {
                // Navigating to Home
                return ChangeNotifierProvider<HomeRepository>(
                    create: (context) => HomeRepository(userModel: userModel),
                    child: const HomeScreen());
              }
            }), (route) => false)));

    return Scaffold(
      backgroundColor: AppColors.backgroundAppColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 9,
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: SvgPicture.asset("assets/app_icon.svg"),
              )),
          const Expanded(flex: 1, child: ProgressBar())
        ],
      ),
    );
  }
}
