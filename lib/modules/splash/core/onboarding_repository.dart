import 'package:flutter/cupertino.dart';

class OnboardingRepository with ChangeNotifier {
  final PageController pageController = PageController();
  final int totalPagesCount = 3;

  int currentPageIndex = 0;

  void scrollToPage(int pageIndex) {
    if (pageIndex < 0 || pageIndex >= totalPagesCount) {
      return;
    }

    pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeIn,
    );

    currentPageIndex = pageIndex;

    notifyListeners();
  }
}
