import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task2/features/authentication/bloc/auth_bloc.dart';
import 'package:task2/features/lookups/models/country_lookups_model.dart';
import 'package:task2/global/methods_helpers_utlis/bottom_sheets_handler.dart';
import 'package:task2/global/methods_helpers_utlis/constants.dart';
import 'package:task2/global/methods_helpers_utlis/media_query.dart';
import 'package:task2/global/methods_helpers_utlis/toast.dart';
import 'package:task2/global/navigation_routes/routes.dart';
import 'package:task2/global/widgets/general_phone_text_field_with_floating_label.dart';
import 'package:task2/global/widgets/general_raw_material_button.dart';
import 'package:task2/global/widgets/return_button.dart';

class SendOtpToPhoneScreen extends StatefulWidget {
  const SendOtpToPhoneScreen({super.key});

  @override
  State<SendOtpToPhoneScreen> createState() => _SendOtpToPhoneScreenState();
}

class _SendOtpToPhoneScreenState extends State<SendOtpToPhoneScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  TextEditingController phoneController = TextEditingController();
  CountryLookupsModel countryLookupsModel = Constants.defaultCountryModel;

  @override
  void initState() {
    super.initState();
    animationController = BottomSheet.createAnimationController(this);
    animationController.duration = const Duration(milliseconds: 500);
  }

  @override
  void dispose() {
    phoneController.dispose();
    animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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

                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Continue with phone",
                      style: TextStyle(fontSize: 17,fontWeight: FontWeight.w800,color: Colors.black),),
                  ],
                ),
                SizedBox(height: MQuery.getheight(context, 46),),

                SvgPicture.asset('assets/images/continuewithphone.svg'),
                SizedBox(height: MQuery.getheight(context, 36),),

                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("You’ll receive a 4 digit code to verify next ",
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Color(0xFF838383)),),
                  ],
                ),

                SizedBox(
                  height: MQuery.getheight(context, 36),
                ),

                GeneralPhoneTextFormField(
                  controller: phoneController,
                  labelText: 'Phone',
                  onChanged: (v) {
                    setState(() {});
                  },
                  validator: (value) {
                    return null;
                  },
                  countryLookupsModel: countryLookupsModel,
                  onTapCountry: () async {
                    FocusScope.of(context).unfocus();

                    CountryLookupsModel? countryLookupsModel2 =
                    await BottomSheetsHandler.chooseCountry(
                        context: context,
                        animationController: animationController,
                        countryLookupsModel: countryLookupsModel);
                    if (countryLookupsModel2 != null) {
                      setState(() {
                        countryLookupsModel = countryLookupsModel2;
                      });
                    }
                  },
                  maxLength: 11,
                ),
                const SizedBox(
                  height: 50,
                ),
                BlocConsumer<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) async {
                    if (state is ErrorToSendOTPState) {
                      ToastClass.toast(
                          context: context, data: state.message, seconds: 3);
                      log(state.message);
                    }

                    if (state is DoneToSendOTPState) {
                      ToastClass.toast(
                          context: context, data: "Otp sent!", seconds: 3);
                      Routes.verifyOtpScreen(
                          context: context,
                          phone: countryLookupsModel.dialCode +
                              phoneController.text.trim());
                    }
                  },
                  builder: (context, state) {
                    return GeneralRawMaterialButton(
                        onPressed: () {
                          if (state is LoadingToSendOTPState) {
                          } else {
                            context.read<AuthenticationBloc>().add(SendOTP(
                                phone: countryLookupsModel.dialCode +
                                    phoneController.text.trim()));
                          }
                        },
                        height: 56,
                        width: MQuery.getWidth(context, 328),
                        backColor: Colors.indigo,
                        borderSideWidth: 1,
                        borderSideColor: const Color(0xFFFFFFFF),
                        radius: MQuery.getheight(context, 10),
                        child: state is LoadingToSendOTPState
                            ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                            : const Text(
                          "Send",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFFFFFFF)),
                        ));
                  },
                ),


                SizedBox(height: MQuery.getheight(context, 100),),


              ],
            ),
          ),
        ],
      ),
    );
  }
}
