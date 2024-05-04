import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:task2/features/authentication/bloc/auth_bloc.dart';
import 'package:task2/global/methods_helpers_utlis/constants.dart';
import 'package:task2/global/methods_helpers_utlis/local_storage_helper.dart';
import 'package:task2/global/methods_helpers_utlis/media_query.dart';
import 'package:task2/global/methods_helpers_utlis/toast.dart';
import 'package:task2/global/navigation_routes/routes.dart';
import 'package:task2/global/widgets/general_password_text_field_with_floating_label.dart';
import 'package:task2/global/widgets/general_raw_material_button.dart';
import 'package:task2/global/widgets/general_text_field_with_floating_label.dart';

class SignInEmailPassWidget extends StatefulWidget {
  const SignInEmailPassWidget({super.key});

  @override
  State<SignInEmailPassWidget> createState() => _SignInEmailPassWidgetState();
}

class _SignInEmailPassWidgetState extends State<SignInEmailPassWidget> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscureText = true;

  final LocalAuthentication localAuthentication = LocalAuthentication();
  bool isBiometricAvailable = false;
  bool isBiometricEnabled = false;
  bool isAuthWithBiometricEnabledBefore = false;


  @override
  void initState() {
    super.initState();
    initBiometric();
  }

  Future<void> initBiometric() async {
    isAuthWithBiometricEnabledBefore =  await LocalStorageHelper.getBool('isAuthWithBiometricEnabledBefore') ?? false;

    bool isAvailable = await localAuthentication.canCheckBiometrics;
    setState(() {
      isBiometricAvailable = isAvailable;
    });
  }

  Future<void> signWithBiometric() async {
    bool isAuthenticated = await authWithBiometric();

    String email = await LocalStorageHelper.getString('email') ??"";
    String password = await LocalStorageHelper.getString('password') ??"";

    if (isAuthenticated) {
      setState(() {
        context.read<AuthenticationBloc>().add(
            SignInEmailPassword(
                email: email,
                password: password));

      });
    }
  }






  Future<bool> authWithBiometric()async{
    bool isAuthenticated = await localAuthentication.authenticate(
      localizedReason: 'Authenticate to access the app',
      options:
      const AuthenticationOptions(biometricOnly: false, stickyAuth: true),
    );
    return isAuthenticated;
  }


  Future<void> resetBiometric()async{
    await LocalStorageHelper.remove('email');
    await LocalStorageHelper.remove('password');
    await LocalStorageHelper.remove('isAuthWithBiometricEnabledBefore');
    isAuthWithBiometricEnabledBefore = false;
    setState(() {});
  }


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
            "Sign in",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: MQuery.getheight(context, 20),
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


          if(isAuthWithBiometricEnabledBefore)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: signWithBiometric, child: const Text("Sign using Biometric")),
                const SizedBox(width: 5,),
                TextButton(onPressed: resetBiometric, child: const Text("Reset Biometric",
                style: TextStyle(color: Colors.red),)),

              ],
            )
          else if(isBiometricAvailable)  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Enable Biometric Auth"),
              const SizedBox(width: 20),
              Switch(
                  value: isBiometricEnabled,
                  onChanged: (val) async{

                    if(isBiometricEnabled){
                      await LocalStorageHelper.setBool('isAuthWithBiometricEnabledBefore', true);
                    }else{
                      await LocalStorageHelper.remove('isAuthWithBiometricEnabledBefore');
                    }
                    setState(() {
                      isBiometricEnabled = val;
                    });


                  }),
            ],
          )
            else const SizedBox.shrink(),

          const SizedBox(
            height: 20,
          ),



          BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state)  {
              if (state is ErrorToSignInEmailPasswordState) {
                ToastClass.toast(
                    context: context,
                    data: state.message,
                    seconds: 3);
                log(state.message);
              }

              if (state is DoneToSignInEmailPasswordState) {
                ToastClass.toast(
                    context: context,
                    data: "Verified successfully ",
                    seconds: 3);




                Routes.mainViewScreen(context: context);
              }
            },
            builder: (context, state) {
              return GeneralRawMaterialButton(
                  onPressed: () async {
                    if (state
                    is LoadingToSignInEmailPasswordState) {
                    } else {








                        if (!Constants.emailRegExp.hasMatch(emailController.text.trim())) {
                          ToastClass.toast(
                              context: context,
                              data: "Please enter valid email",
                              seconds: 3);
                        }
                        else if(passwordController.text.trim().length < 6){
                          ToastClass.toast(
                              context: context,
                              data: "Password length should be 6 or more",
                              seconds: 3);
                        }
                        else{






                          if(!isAuthWithBiometricEnabledBefore && isBiometricEnabled){
                            bool isAuthenticated = await authWithBiometric();


                            if(isAuthenticated){

                              await LocalStorageHelper.setBool('isAuthWithBiometricEnabledBefore', true);
                              await LocalStorageHelper.setString('email', emailController.text.trim());
                              await LocalStorageHelper.setString('password', passwordController.text.trim());

                              SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                                context.read<AuthenticationBloc>().add(
                                    SignInEmailPassword(
                                        email: emailController.text.trim(),
                                        password: passwordController.text
                                            .trim()));
                              });


                            }

                          }else{
                            context.read<AuthenticationBloc>().add(
                                SignInEmailPassword(
                                    email: emailController.text.trim(),
                                    password: passwordController.text
                                        .trim()));
                          }



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
                  state is LoadingToSignInEmailPasswordState
                      ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                      : const Text(
                    "Sign In",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFFFFFFF)),
                  ));
            },
          ),




        ],
      ),
    );
  }
}
