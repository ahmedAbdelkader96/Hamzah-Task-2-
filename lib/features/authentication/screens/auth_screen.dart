import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/features/authentication/widgets/sign_in_email_pass_widget.dart';
import 'package:task2/features/authentication/widgets/sign_up_email_pass_widget.dart';
import 'package:task2/features/authentication/widgets/sign_with_google_button.dart';
import 'package:task2/features/authentication/widgets/sign_with_phone_button.dart';
import 'package:task2/features/lookups/blocs/countries_lookups/countries_lookups_bloc.dart';
import 'package:task2/global/methods_helpers_utlis/media_query.dart';


class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>{



  @override
  void initState() {
    super.initState();
    context.read<CountriesLookupsBloc>().add(const FetchCountries());
  }



  CrossFadeState crossFadeState = CrossFadeState.showFirst;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Task 3"),
              SizedBox(
                height: MQuery.getheight(context, 40),
              ),
              AnimatedCrossFade(
                  crossFadeState: crossFadeState,
                  duration: const Duration(milliseconds: 150),
                  reverseDuration: const Duration(milliseconds: 150),
                  firstCurve: Curves.linear,
                  secondCurve: Curves.linear,
                  sizeCurve: Curves.linear,
                  firstChild: const SignInEmailPassWidget(),
                  secondChild: const SignUpEmailPassWidget()),


              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Need an account ?",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF8D8D8D)),
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                        shadowColor: const Color(0xFF017AFE),
                      ),
                      onPressed: () {
                        setState(() {
                          if (crossFadeState.index == 0) {
                            crossFadeState = CrossFadeState.showSecond;
                          } else {
                            crossFadeState = CrossFadeState.showFirst;
                          }
                        });
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF017AFE),
                            decoration: TextDecoration.underline),
                      )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const SignWithGoogleButton(),

                  SizedBox(
                    width: MQuery.getWidth(context, 16),
                  ),
                  const SignWithPhoneButton(),
                ],
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
