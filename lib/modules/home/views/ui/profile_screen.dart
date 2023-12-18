import 'package:devanshhooda/modules/home/core/home_repository.dart';
import 'package:devanshhooda/modules/home/views/widgets/tile_buttons_container.dart';
import 'package:devanshhooda/modules/splash/views/ui/splash_screen.dart';
import 'package:devanshhooda/shared_widgets/common_button.dart';
import 'package:devanshhooda/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.homeRepository});
  final HomeRepository homeRepository;

  static const _tileButtonsData1 = {
    "My Payments": Icons.energy_savings_leaf,
    "My Electric Vehicles": Icons.car_crash,
    "My Favourite Stations": Icons.favorite,
    "Alpha Membership": Icons.card_membership
  };

  static const _tileButtonsData2 = {
    "My Devices": Icons.devices,
    "My Orders": Icons.shopping_cart
  };

  static const _tileButtonsData3 = {
    "Help": Icons.help,
    "Raise Complaint": Icons.warning_amber_outlined,
    "About Us": Icons.privacy_tip,
    "Privacy Policy": Icons.edit_document
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundAppColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.backgroundAppColor,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(25),
            child: Column(
              children: [
                const Text("Hello",
                    style: TextStyle(color: Colors.white60, fontSize: 17)),
                (homeRepository.userModel.firstName != null &&
                        homeRepository.userModel.lastName != null)
                    ? Text(
                        homeRepository.userModel.firstName! +
                            " " +
                            homeRepository.userModel.lastName!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : const SizedBox()
              ],
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const SizedBox(
                height: 280,
                child: TileButtonsContainer(tileButtonsData: _tileButtonsData1),
              ),
              const SizedBox(height: 20),
              CommonButton(
                  buttonText: "Buy Machines from chargeMOD",
                  onPressed: () =>
                      print("Buy Machines from chargeMOD button was pressed")),
              const SizedBox(height: 20),
              const SizedBox(
                height: 140,
                child: TileButtonsContainer(tileButtonsData: _tileButtonsData2),
              ),
              const SizedBox(height: 20),
              const SizedBox(
                height: 280,
                child: TileButtonsContainer(tileButtonsData: _tileButtonsData3),
              ),
              const SizedBox(height: 20),
              CommonButton(
                  buttonText: "Logout",
                  onPressed: () =>
                      homeRepository.logoutUser().then((result) => {
                            if (result == true)
                              Navigator.of(context).pushAndRemoveUntil(
                                  CupertinoPageRoute(
                                      builder: (context) => SplashScreen()),
                                  (route) => false)
                          })),
              const SizedBox(height: 50),
              SvgPicture.asset("assets/profile_page_logo.svg"),
              const SizedBox(height: 20),
              const Text(
                'V 1.0.0 (001)',
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'Copyright © 2022 BPM Power Pvt Ltd.\nAll rights reserved.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
