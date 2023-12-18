import 'package:devanshhooda/modules/splash/views/widets/onboarding_screen_widget.dart';
import 'package:devanshhooda/modules/splash/views/widets/onboarding_screens_footer.dart';
import 'package:devanshhooda/shared_widgets/onboarding_header.dart';
import 'package:flutter/cupertino.dart';

class OnBoardingScreen2 extends StatelessWidget {
  const OnBoardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return const OnBoardingScreenWidget(
        onBoardingHeader: OnBoardingHeader(
            headerText: "Easy EV Navigation",
            middleText: "Travel Route",
            footerText: "For Electrics"),
        onBoardingFooter: OnBoardingFooter(
            footerText:
                "Grab The Best In Class \nDigital Experience Crafted For \nEV Drivers"));
  }
}
