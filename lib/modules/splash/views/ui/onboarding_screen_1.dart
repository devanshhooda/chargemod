import 'package:devanshhooda/modules/splash/views/widets/onboarding_screen_widget.dart';
import 'package:devanshhooda/modules/splash/views/widets/onboarding_screens_footer.dart';
import 'package:devanshhooda/shared_widgets/onboarding_header.dart';
import 'package:flutter/cupertino.dart';

class OnBoardingScreen1 extends StatelessWidget {
  const OnBoardingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return const OnBoardingScreenWidget(
        onBoardingHeader: OnBoardingHeader(
            headerText: "Charge Your EV",
            middleText: "At Your",
            footerText: "Fingertips"),
        onBoardingFooter: OnBoardingFooter(
            footerText: "Scan Charge and Go \nEffortless Charging schemas"));
  }
}
