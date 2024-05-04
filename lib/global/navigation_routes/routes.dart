import 'package:flutter/cupertino.dart';
import 'package:task2/features/authentication/screens/auth_screen.dart';
import 'package:task2/features/authentication/screens/send_otp_to_phone_screen.dart';
import 'package:task2/features/authentication/screens/verify_otp_screen.dart';
import 'package:task2/features/main_view/screens/main_view_screen.dart';

class Routes {



  static Future<dynamic> authScreen(
      {required BuildContext context}) async {
    return Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(
            builder: (context) => AuthScreen()),
        (Route<dynamic> route) => false);
  }



  static Future<dynamic> sendOtpToPhoneScreen(
      {required BuildContext context}) async {
    return Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => SendOtpToPhoneScreen()));
  }



  static Future<dynamic> verifyOtpScreen(
      {required BuildContext context , required String phone}) async {
    return Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => VerifyOtpScreen(phone:phone)));
  }



  static Future<dynamic> mainViewScreen(
      {required BuildContext context}) async {
    return Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(
            builder: (context) => MainViewScreen()),
            (Route<dynamic> route) => false);
  }


}
