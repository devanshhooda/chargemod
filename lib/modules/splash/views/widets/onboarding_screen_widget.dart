import 'package:devanshhooda/shared_widgets/onboarding_header.dart';
import 'package:flutter/cupertino.dart';

import 'onboarding_screens_footer.dart';

class OnBoardingScreenWidget extends StatelessWidget {
  const OnBoardingScreenWidget({
    super.key,
    required this.onBoardingHeader,
    required this.onBoardingFooter,
  });
  final OnBoardingHeader onBoardingHeader;
  final OnBoardingFooter onBoardingFooter;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        onBoardingHeader,
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset("assets/charger_image.png")),
        onBoardingFooter
      ],
    );
  }
}
