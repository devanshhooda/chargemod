import 'package:devanshhooda/modules/user_profile/core/user_profile_repository.dart';
import 'package:flutter/material.dart';

class ProfileDetailsTextfield extends StatelessWidget {
  const ProfileDetailsTextfield(
      {super.key,
      required this.hintText,
      required this.textEditingController,
      required this.userProfileRepository,
      this.isEmail = false});
  final String hintText;
  final bool isEmail;
  final TextEditingController textEditingController;
  final UserProfileRepository userProfileRepository;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      style: const TextStyle(fontSize: 15, height: 1, color: Colors.black87),
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.name,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black45),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      // Remoing error prompt here
      onChanged: (value) {
        if (userProfileRepository.updateUserError != null) {
          userProfileRepository.removeErrorPrompts();
        }
      },
    );
  }
}
