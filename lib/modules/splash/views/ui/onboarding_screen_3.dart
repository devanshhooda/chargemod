import 'package:devanshhooda/modules/splash/views/widets/onboarding_screen_widget.dart';
import 'package:devanshhooda/modules/splash/views/widets/onboarding_screens_footer.dart';
import 'package:devanshhooda/shared_widgets/onboarding_header.dart';
import 'package:flutter/cupertino.dart';

class OnBoardingScreen3 extends StatelessWidget {
  const OnBoardingScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return const OnBoardingScreenWidget(
        onBoardingHeader: OnBoardingHeader(
            headerText: "Interactions with Grid",
            middleText: "RealTime",
            footerText: "Monitoring"),
        onBoardingFooter: OnBoardingFooter(
            footerText: "Intelligent Sensible Devices \nAmbicharge Series"));
  }
}
