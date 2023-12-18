import 'package:country_picker/country_picker.dart';
import 'package:devanshhooda/modules/sign_in/core/login_repository.dart';
import 'package:flutter/material.dart';

class PhoneCodePicker extends StatelessWidget {
  const PhoneCodePicker({super.key, required this.loginRepository});
  final LoginRepository loginRepository;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showCountryPicker(
            context: context,
            useSafeArea: true,
            // Changing the selected country here
            onSelect: (Country selectedCountry) => loginRepository
                .changeSelectedCountry(selectedCountry: selectedCountry));
      },
      child: Container(
          height: 50,
          width: 70,
          padding: const EdgeInsets.only(left: 5, right: 2.5),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  loginRepository.selectedCountry.flagEmoji,
                  style: const TextStyle(fontSize: 30),
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.black54,
              )
            ],
          )),
    );
  }
}
