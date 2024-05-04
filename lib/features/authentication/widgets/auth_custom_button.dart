import 'package:flutter/material.dart';

class AuthCustomButton extends StatelessWidget {
  const AuthCustomButton(
      {super.key, required this.onPressed, required this.child});
  final Function() onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      padding: const EdgeInsets.all(11),
      constraints: const BoxConstraints(
          minWidth: 52,
          maxHeight: 52,
          maxWidth: 52,
          minHeight: 52),
      fillColor: const Color(0xFFF4F4F4),
      elevation: 4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      onPressed: onPressed,
      child: child,
    );
  }
}
