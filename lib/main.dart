import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instaclone_again/pages/signin_page.dart';
import 'package:instaclone_again/pages/splash_page.dart';
import 'package:instaclone_again/services/notif_service.dart';

import 'pages/home_page.dart';
import 'pages/signup_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDG1r2QmHfjd0o-8TKXBQ-VnrzLCKStsXw',
      appId: '1:181524414289:android:d4ef9f358a1bad77e75d70',
      messagingSenderId: '181524414289',
      projectId: 'instaclone-again',
    ),
  );

  await NotifService().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashPage(),
      routes: {
        SplashPage.id:(context) => SplashPage(),
        HomePage.id:(context) => HomePage(),
        SignInPage.id:(context) => SignInPage(),
        SignUpPage.id:(context) => SignUpPage(),
      },
    );

  }
}