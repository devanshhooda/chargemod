import 'package:devanshhooda/modules/sign_in/core/login_repository.dart';
import 'package:flutter/material.dart';

import 'phone_code_picker.dart';

class PhoneNumberTextfield extends StatelessWidget {
  const PhoneNumberTextfield({super.key, required this.loginRepository});
  final LoginRepository loginRepository;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PhoneCodePicker(loginRepository: loginRepository),
          const SizedBox(width: 5),
          Expanded(
            child: TextField(
              controller: loginRepository.phoneNumberController,
              keyboardType: TextInputType.phone,
              style: const TextStyle(
                  fontSize: 15, height: 1, color: Colors.black87),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Enter phone number',
                  hintStyle: const TextStyle(color: Colors.black45),
                  prefixIcon: const Icon(
                    Icons.phone_outlined,
                    size: 17,
                    color: Colors.black45,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              // Remoing error prompt here
              onChanged: (value) => {
                if (loginRepository.phoneNumberError != null)
                  {loginRepository.removeErrorPrompt()}
              },
            ),
          )
        ],
      ),
    );
  }
}
