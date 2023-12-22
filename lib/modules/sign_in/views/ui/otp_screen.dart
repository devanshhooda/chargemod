import 'package:devanshhooda/data/models/user_model/user_model.dart';
import 'package:devanshhooda/modules/home/core/home_repository.dart';
import 'package:devanshhooda/modules/home/views/ui/home_screen.dart';
import 'package:devanshhooda/modules/sign_in/core/otp_repository.dart';
import 'package:devanshhooda/modules/sign_in/views/widgets/otp_screen/otp_screen_header.dart';
import 'package:devanshhooda/modules/sign_in/views/widgets/otp_screen/otp_screen_middle_content.dart';
import 'package:devanshhooda/modules/user_profile/core/user_profile_repository.dart';
import 'package:devanshhooda/modules/user_profile/views/ui/update_profile_screen.dart';
import 'package:devanshhooda/shared_widgets/common_button.dart';
import 'package:devanshhooda/shared_widgets/loading_overlay_screen.dart';
import 'package:devanshhooda/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late OtpRepository _otpRepository;

  @override
  Widget build(BuildContext context) {
    _otpRepository = Provider.of<OtpRepository>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundAppColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),

                const OtpHeader(),

                const SizedBox(height: 10),

                Expanded(
                    child: OtpMiddleContent(otpRepository: _otpRepository)),

                // Continue button here
                CommonButton(
                  buttonText: "CONTINUE",
                  onPressed: () {
                    _otpRepository.verifyOtp().then((UserModel? userModel) => {
                          if (userModel != null)
                            Navigator.of(context).pushAndRemoveUntil(
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        // If its a new user
                                        (userModel.isNewUser == true)
                                            ?
                                            // Navigate to UpdateProfileScreen
                                            ChangeNotifierProvider<
                                                    UserProfileRepository>(
                                                create: (context) =>
                                                    UserProfileRepository(
                                                        phoneNumber:
                                                            _otpRepository
                                                                .phoneNumber),
                                                child:
                                                    const UpdateProfileScreen())
                                            :
                                            // Else navigate to HomeScreen
                                            ChangeNotifierProvider<
                                                    HomeRepository>(
                                                create: (context) =>
                                                    HomeRepository(
                                                        userModel: userModel),
                                                child: const HomeScreen())),
                                (route) => false)
                        });
                  },
                ),

                const SizedBox(
                  height: 30,
                ),
              ],
            ),
            _otpRepository.isLoading
                ? const LoadingOverlayScreen()
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
