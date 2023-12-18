import 'package:devanshhooda/modules/sign_in/core/login_repository.dart';
import 'package:devanshhooda/modules/sign_in/views/widgets/login_screen/login_footer.dart';
import 'package:devanshhooda/modules/sign_in/views/widgets/login_screen/login_middle_content.dart';
import 'package:devanshhooda/shared_widgets/loading_overlay_screen.dart';
import 'package:devanshhooda/shared_widgets/onboarding_header.dart';
import 'package:devanshhooda/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginRepository _loginRepository;

  @override
  Widget build(BuildContext context) {
    _loginRepository = Provider.of<LoginRepository>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundAppColor,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(
                      child: OnBoardingHeader(
                          headerText: 'ChargeMOD',
                          middleText: "Let's Start",
                          footerText: "From Login")),
                  Expanded(
                      child: LoginMiddleContent(
                    loginRepository: _loginRepository,
                  )),
                  const Expanded(child: LoginPageFooter())
                ],
              ),
            ),
            _loginRepository.isLoading
                ? const LoadingOverlayScreen()
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
