import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:task2/features/authentication/bloc/auth_bloc.dart';
import 'package:task2/global/methods_helpers_utlis/media_query.dart';
import 'package:task2/global/methods_helpers_utlis/toast.dart';
import 'package:task2/global/navigation_routes/routes.dart';
import 'package:task2/global/widgets/general_raw_material_button.dart';
import 'package:task2/global/widgets/return_button.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key, required this.phone});
  final String phone;

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {



final TextEditingController pinPutController = TextEditingController();
final FocusNode pinFocusNode = FocusNode();
final defaultPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: const TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.w600),
  decoration: BoxDecoration(
      color: const Color(0xFFF4F4F4),
      border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
            color: const Color(0xFF686868).withOpacity(0.15),
            blurRadius:2 ,
            offset: const Offset(0,2)
        )
      ]
  ),
);


@override
  void dispose() {
  timer.cancel();
  pinPutController.dispose();
    // TODO: implement dispose
    super.dispose();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }








late Timer timer;
int start = 60;
bool isLoading = false;
int remainMinutes = 0;
int remainSeconds = 0;
String remainMinutesText = "02";
String remainSecondsText = "00";

void startTimer() {
  const oneSec = Duration(seconds: 1);
  timer = Timer.periodic(
    oneSec,
        (Timer timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          isLoading = false;
        });
      } else {
        setState(() {
          start--;
          debugPrint("_start is : $start");
          remainMinutes = Duration(seconds: start).inMinutes;
          if (remainMinutes < 10) {
            remainMinutesText = "0$remainMinutes";
          } else {
            remainMinutesText = "$remainMinutes";
          }
          remainSeconds = Duration(seconds: start).inSeconds -
              Duration(seconds: start).inMinutes * 60;
          if (remainSeconds < 10) {
            remainSecondsText = "0$remainSeconds";
          } else {
            remainSecondsText = "$remainSeconds";
          }
        });
      }
    },
  );
}






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
        children: [
          SizedBox(
            height: MQuery.getheight(context, 40),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: MQuery.getWidth(context, 5),
                right: MQuery.getWidth(context, 5)),
            child: const Row(
              children: [
                ReturnButton()
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.only(left: MQuery.getWidth(context, 16),
                  right: MQuery.getWidth(context, 16)),
              children: [



                SizedBox(height: MQuery.getheight(context, 10),),

                const Text(
                  "Verify Phone",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                SizedBox(height: MQuery.getheight(context, 36),),

                Text(
                  "Code is sent to ${widget.phone}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF838383)),
                ),
                SizedBox(
                  height: MQuery.getheight(context, 45),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Pinput(
                    length: 6,
                    defaultPinTheme: defaultPinTheme,
                    focusNode: pinFocusNode,
                    controller: pinPutController,
                    pinAnimationType: PinAnimationType.fade,
                    onChanged: (pin) async {
                      if(pin.length == 6){

                        context.read<AuthenticationBloc>().add(VerifyOTP(
                            phone: widget.phone,otp: pinPutController.text.trim()));

                      }




                    },
                    textInputAction: TextInputAction.done,

                  ),
                ),
                SizedBox(
                  height: MQuery.getheight(context, 41),
                ),


                const SizedBox(
                  height: 50,
                ),
                BlocConsumer<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) async {
                    if (state is ErrorToVerifyOTPState) {
                      ToastClass.toast(
                          context: context, data: state.message, seconds: 3);
                      log(state.message);

                    }

                    if (state is DoneToVerifyOTPState) {
                      ToastClass.toast(
                          context: context, data: "Phone verified successfully", seconds: 3);
                      Routes.mainViewScreen(context: context);
                    }
                  },
                  builder: (context, state) {
                    return GeneralRawMaterialButton(
                        onPressed: () {
                          if (state is LoadingToVerifyOTPState) {
                          } else {
                            context.read<AuthenticationBloc>().add(VerifyOTP(
                                phone: widget.phone,otp: pinPutController.text.trim()));
                          }
                        },
                        height: 56,
                        width: MQuery.getWidth(context, 328),
                        backColor: Colors.indigo,
                        borderSideWidth: 1,
                        borderSideColor: const Color(0xFFFFFFFF),
                        radius: MQuery.getheight(context, 10),
                        child: state is LoadingToVerifyOTPState
                            ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                            : const Text(
                          "Verify",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFFFFFFF)),
                        ));
                  },
                ),

                SizedBox(
                  height: 70,width: MQuery.getWidth(context, 360),
                  child:
                  isLoading?
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator()
                    ],
                  )
                      : start == 0?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text("OTP Verfication to ${widget.phone}",textAlign: TextAlign.center,
                      //   style: TextStyle(fontSize: 24,fontWeight: FontWeight.w700,color: Colors.white),),

                      const Text("Didn’t Receive your OTP?",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF838383))),
                      TextButton(
                        onPressed: () {
                          //verifyPhoneNumber();
                        },
                        child: const Text("Click here to resend",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF252525))),
                      )
                    ],
                  )
                      :
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("$remainMinutesText : $remainSecondsText",
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white)),
                    ],
                  ),
                ),


                SizedBox(height: MQuery.getheight(context, 100),),


              ],
            ),
          ),
        ],
      )

    );
  }
}
