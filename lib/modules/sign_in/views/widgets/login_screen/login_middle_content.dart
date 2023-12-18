import 'package:devanshhooda/modules/sign_in/core/login_repository.dart';
import 'package:devanshhooda/modules/sign_in/core/otp_repository.dart';
import 'package:devanshhooda/modules/sign_in/views/ui/otp_screen.dart';
import 'package:devanshhooda/shared_widgets/common_button.dart';
import 'package:devanshhooda/shared_widgets/error_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'phone_textfield.dart';

class LoginMiddleContent extends StatelessWidget {
  const LoginMiddleContent({super.key, required this.loginRepository});

  final LoginRepository loginRepository;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Phone number field
        PhoneNumberTextfield(loginRepository: loginRepository),

        const SizedBox(height: 8),

        // Send OTP button
        CommonButton(
          buttonText: "Send OTP",
          onPressed: () {
            // Hitting API here to Send OTP and navigating to OTP screen if Success
            loginRepository.signIn().then((result) => {
                  if (result == true)
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                                create: (context) => OtpRepository(
                                    phoneNumber: loginRepository.phoneNumber),
                                child: const OtpScreen())))
                });
          },
        ),

        const SizedBox(height: 8),

        loginRepository.phoneNumberError != null
            ?
            // Error box
            ErrorBox(errorMessage: loginRepository.phoneNumberError!)
            : const SizedBox(),
      ],
    );
  }
}
