import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task2/features/authentication/controller/controller.dart';
import 'package:task2/global/navigation_routes/routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    initPage();
  }

  Future<void> initPage() async {
    final AuthController authController = AuthController();
    Session? currentSession = await authController.getCurrentSession();

    if (currentSession != null) {
      if (currentSession.isExpired) {
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          Routes.authScreen(context: context);
        });
      } else {
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          Routes.mainViewScreen(context: context);
        });

      }
    } else {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Routes.authScreen(context: context);
      });
    }
  }

  @override
  void didUpdateWidget(covariant SplashPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hamzah Task 3",
              style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            SizedBox(
              height: 30,
            ),
            CircularProgressIndicator(
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
