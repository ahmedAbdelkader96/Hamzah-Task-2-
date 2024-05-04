import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/features/authentication/bloc/auth_bloc.dart';
import 'package:task2/features/authentication/models/user_model.dart';
import 'package:task2/features/lookups/models/country_lookups_model.dart';
import 'package:task2/global/methods_helpers_utlis/bottom_sheets_handler.dart';
import 'package:task2/global/methods_helpers_utlis/constants.dart';
import 'package:task2/global/methods_helpers_utlis/media_query.dart';
import 'package:task2/global/methods_helpers_utlis/toast.dart';
import 'package:task2/global/navigation_routes/routes.dart';
import 'package:task2/global/widgets/general_password_text_field_with_floating_label.dart';
import 'package:task2/global/widgets/general_phone_text_field_with_floating_label.dart';
import 'package:task2/global/widgets/general_raw_material_button.dart';
import 'package:task2/global/widgets/general_text_field_with_floating_label.dart';

class SignUpEmailPassWidget extends StatefulWidget {
  const SignUpEmailPassWidget({super.key});

  @override
  State<SignUpEmailPassWidget> createState() => _SignUpEmailPassWidgetState();
}

class _SignUpEmailPassWidgetState extends State<SignUpEmailPassWidget>  with TickerProviderStateMixin {


  late AnimationController animationController;
  CountryLookupsModel countryLookupsModel = Constants.defaultCountryModel;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController jobTitleController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscureText = true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = BottomSheet.createAnimationController(this);
    animationController.duration = const Duration(milliseconds: 500);
  }


  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Sign up to Save Profile",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: MQuery.getheight(context, 24),
          ),
          GeneralTextFieldWithFloatingLabel(
            controller: nameController,
            labelText: "Name",
            onChanged: (v) {
              setState(() {});
            },
            validator: (value) {
              return null;
            },
            color: Colors.indigo,
          ),
          const SizedBox(
            height: 20,
          ),
          GeneralTextFieldWithFloatingLabel(
            controller: emailController,
            labelText: "Email",
            onChanged: (v) {
              setState(() {});
            },
            validator: (value) {
              return null;
            },
            color: Colors.indigo,
          ),
          const SizedBox(
            height: 20,
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
            height: 20,
          ),
          GeneralTextFieldWithFloatingLabel(
            controller: jobTitleController,
            labelText: "Job Title",
            onChanged: (v) {
              setState(() {});
            },
            validator: (value) {
              return null;
            },
            color: Colors.indigo,
          ),

          const SizedBox(
            height: 20,
          ),
          GeneralPasswordTextFieldWithFloatingLabel(
              controller: passwordController,
              labelText: "Password",
              obscureText: obscureText,
              onChanged: (v) {},
              changeObsecureValue: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              validator: null,
              color: Colors.indigo),
          const SizedBox(
            height: 20,
          ),
          BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) async {
              if (state
              is ErrorToSignUpEmailPasswordAndCreateAccountState) {
                ToastClass.toast(
                    context: context,
                    data: state.message,
                    seconds: 3);
                log(state.message);
              }

              if (state
              is DoneToSignUpEmailPasswordAndCreateAccountState) {
                ToastClass.toast(
                    context: context,
                    data: "Account created successfully",
                    seconds: 3);
                Routes.mainViewScreen(context: context);
              }
            },
            builder: (context, state) {
              return GeneralRawMaterialButton(
                  onPressed: () {
                    if (state
                    is LoadingToSignUpEmailPasswordAndCreateAccountState) {
                    } else {

                      if(nameController.text.trim().isEmpty){
                        ToastClass.toast(context: context, data: "Name should be provided!", seconds: 3);
                      }else  if (!Constants.emailRegExp.hasMatch(emailController.text.trim())) {
                        ToastClass.toast(
                            context: context,
                            data: "Please enter valid email",
                            seconds: 3);
                      }else if(phoneController.text.trim().isEmpty){
                        ToastClass.toast(
                            context: context,
                            data: "Phone should be provided!",
                            seconds: 3);
                      }else if(jobTitleController.text.trim().isEmpty){
                        ToastClass.toast(
                            context: context,
                            data: "Job Title should be provided!",
                            seconds: 3);
                      }else if(passwordController.text.trim().length < 6){
                        ToastClass.toast(
                            context: context,
                            data: "Password length should be 6 or more",
                            seconds: 3);
                      }else{

                        final userModel = UserModel(
                            userId: "",
                            createdAt: DateTime.now(),
                            name: nameController.text.trim(),
                            jobTitle: jobTitleController.text.trim(),
                            phone: countryLookupsModel.dialCode+phoneController.text.trim(),
                            email: emailController.text.trim());
                        context.read<AuthenticationBloc>().add(
                            SignUpEmailPasswordAndCreateAccount(
                                userModel: userModel,
                                password: passwordController.text.trim()));

                      }





                    }
                  },
                  height: 56,
                  width: MQuery.getWidth(context, 328),
                  backColor: Colors.indigo,
                  borderSideWidth: 1,
                  borderSideColor: const Color(0xFFFFFFFF),
                  radius: MQuery.getheight(context, 10),
                  child:
                  state is LoadingToSignUpEmailPasswordAndCreateAccountState
                      ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                      : const Text(
                    "Sign Up",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFFFFFFF)),
                  ));
            },
          )
        ],
      ),
    );
  }
}
