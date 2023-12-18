import 'package:devanshhooda/data/models/user_model.dart';
import 'package:devanshhooda/modules/home/core/home_repository.dart';
import 'package:devanshhooda/modules/home/views/ui/home_screen.dart';
import 'package:devanshhooda/modules/user_profile/core/user_profile_repository.dart';
import 'package:devanshhooda/modules/user_profile/views/widgets/common_section_column.dart';
import 'package:devanshhooda/shared_widgets/common_button.dart';
import 'package:devanshhooda/shared_widgets/error_box.dart';
import 'package:devanshhooda/shared_widgets/loading_overlay_screen.dart';
import 'package:devanshhooda/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserProfileRepository userProfileRepository =
        Provider.of<UserProfileRepository>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundAppColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundAppColor,
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Text(
              'Update Profile',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            )),
      ),
      body: Center(
        child: SafeArea(
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    const SizedBox(height: 25),

                    // First Name
                    CommonSectionColumn(
                        columnText: "First Name",
                        userProfileRepository: userProfileRepository),

                    const SizedBox(height: 20),

                    // Last Name
                    CommonSectionColumn(
                        columnText: "Last Name",
                        userProfileRepository: userProfileRepository),

                    const SizedBox(height: 20),

                    // E-mail
                    CommonSectionColumn(
                        isEmail: true,
                        columnText: "E-mail",
                        userProfileRepository: userProfileRepository),

                    const SizedBox(height: 20),

                    // Phone Number
                    CommonSectionColumn(
                        hasTextField: false,
                        columnText: "Phone Number",
                        userProfileRepository: userProfileRepository),

                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Expanded(child: SizedBox()),

                          userProfileRepository.updateUserError != null
                              ?
                              // Error box
                              ErrorBox(
                                  errorMessage:
                                      userProfileRepository.updateUserError!)
                              : const SizedBox(),

                          const SizedBox(height: 10),

                          const Text(
                            'Completing Your Profile',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          const SizedBox(height: 10),

                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            child: Text(
                              'This action will reflect in your activities and payments after saving. we ask for email details for recieving monthly activity and notifications.',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 8,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          // Save Changes button
                          CommonButton(
                              buttonText: "Save Changes",
                              onPressed: () {
                                userProfileRepository
                                    .updateUserProfile()
                                    .then((UserModel? userModel) => {
                                          if (userModel != null)
                                            Navigator.of(context).pushAndRemoveUntil(
                                                CupertinoPageRoute(
                                                    builder: (context) =>
                                                        ChangeNotifierProvider<
                                                                HomeRepository>(
                                                            create: (context) =>
                                                                HomeRepository(
                                                                    userModel:
                                                                        userModel),
                                                            child:
                                                                const HomeScreen())),
                                                (route) => false)
                                        });
                              })
                        ],
                      ),
                    ),

                    const SizedBox(height: 25)
                  ],
                ),
              ),
              userProfileRepository.isLoading
                  ? const LoadingOverlayScreen()
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
