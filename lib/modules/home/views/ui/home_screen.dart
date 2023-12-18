import 'package:devanshhooda/modules/home/core/home_repository.dart';
import 'package:devanshhooda/modules/home/views/ui/profile_screen.dart';
import 'package:devanshhooda/shared_widgets/loading_overlay_screen.dart';
import 'package:devanshhooda/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Map<String, String> _bottomContent = {
    "Home": "assets/home_icon.svg",
    "Activity": "assets/activity_icon.svg",
    "Community": "assets/community_icon.svg",
    "Profile": "assets/profile_icon.svg",
  };

  @override
  Widget build(BuildContext context) {
    final HomeRepository homeRepository = Provider.of<HomeRepository>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundAppColor,
      body: homeRepository.isLoading == false
          ? SafeArea(
              child: PageView(
              controller: homeRepository.pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: homeRepository.scrollToPage,
              children: [
                const Center(child: Text("Home page")),
                const Center(child: Text("Activity page")),
                const Center(child: Text("Community page")),
                ProfileScreen(
                  homeRepository: homeRepository,
                )
              ],
            ))
          : const LoadingOverlayScreen(),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
        child: BottomNavigationBar(
            iconSize: 30,
            currentIndex: homeRepository.currentPageIndex,
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.white,
            fixedColor: AppColors.primaryColor,
            onTap: homeRepository.scrollToPage,
            items: _bottomContent.keys
                .map(
                  (tabName) => BottomNavigationBarItem(
                    label: tabName,
                    icon: SvgPicture.asset(_bottomContent[tabName]!),
                  ),
                )
                .toList()),
      ),
    );
  }
}
