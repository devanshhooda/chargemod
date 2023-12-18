import 'package:devanshhooda/modules/user_profile/core/user_profile_repository.dart';
import 'package:flutter/material.dart';
import 'profile_details_textfield.dart';

class CommonSectionColumn extends StatelessWidget {
  const CommonSectionColumn(
      {super.key,
      required this.columnText,
      this.hasTextField = true,
      this.isEmail = false,
      required this.userProfileRepository});
  final String columnText;
  final bool hasTextField;
  final bool isEmail;
  final UserProfileRepository userProfileRepository;

  static const TextStyle _headingTextStyle = TextStyle(
    fontSize: 12,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {
    final TextEditingController textEditingController = (isEmail == true)
        ? userProfileRepository.emailController
        : (columnText.contains("First") == true)
            ? userProfileRepository.firstNameController
            : userProfileRepository.lastNameController;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(columnText, style: _headingTextStyle),
          const SizedBox(height: 5),
          hasTextField
              ? ProfileDetailsTextfield(
                  isEmail: isEmail,
                  hintText: columnText,
                  textEditingController: textEditingController,
                  userProfileRepository: userProfileRepository)
              : Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(userProfileRepository.phoneNumber),
                )
        ],
      ),
    );
  }
}
