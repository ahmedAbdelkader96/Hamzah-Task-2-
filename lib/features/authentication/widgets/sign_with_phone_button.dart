import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task2/features/authentication/widgets/auth_custom_button.dart';
import 'package:task2/global/navigation_routes/routes.dart';

class SignWithPhoneButton extends StatelessWidget {
  const SignWithPhoneButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthCustomButton(
      onPressed: () {
        Routes.sendOtpToPhoneScreen(context: context);
      },
      child: SvgPicture.asset('assets/images/phone_colored.svg'),
    );
  }
}
