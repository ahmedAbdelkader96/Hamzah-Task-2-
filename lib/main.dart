import 'dart:developer';

import 'package:encrypt/encrypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:local_auth/local_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task2/features/authentication/models/user_model.dart';
import 'package:task2/features/splash/screens/splash_screen.dart';
import 'package:task2/global/bloc_providers/bloc_providers.dart';
import 'package:task2/global/methods_helpers_utlis/encryption.dart';
import 'package:task2/global/methods_helpers_utlis/local_storage_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: "assets/.env");
  await Supabase.initialize(
    url: dotenv.env['supabaseUrl'].toString(),
    anonKey: dotenv.env['supabaseAnonKey'].toString(),
  );



  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
      MultiBlocProvider(
        providers: BlocProviders.providers,
        child: const CupertinoApp(
          debugShowCheckedModeBanner: false,
          title: "Hamzah Task 2",
          home: SplashPage(),
          localizationsDelegates: [
            DefaultMaterialLocalizations.delegate
          ],
        ),


      );
  }
}


