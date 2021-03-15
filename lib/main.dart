import 'dart:io';

import 'package:ezi_cabs/screens/loginpage.dart';
import 'package:ezi_cabs/screens/registrationpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:ezi_cabs/screens/mainpage.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await Firebase.initializeApp(
    name: 'db2',
    options: Platform.isIOS || Platform.isMacOS
        ? FirebaseOptions(
      appId: '1:297855924061:ios:c6de2b69b03a5be8',
      apiKey: 'AIzaSyD_shO5mfO9lhy2TVWhfo1VUmARKlG4suk',
      projectId: 'flutter-firebase-plugins',
      messagingSenderId: '297855924061',
      databaseURL: 'https://flutterfire-cd2f7.firebaseio.com',
    )
        : FirebaseOptions(
      appId: '1:251997036783:android:deffd45e7fee503fbf3b1a',
      apiKey: 'AIzaSyAeZdwrbOTNDZgM-qH2xs_Casw1qEXsfG8',
      messagingSenderId: '297855924061',
      projectId: 'flutter-firebase-plugins',
      databaseURL: 'https://cabs-7154d-default-rtdb.firebaseio.com',
    ),
  );
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Brand-Regular',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: RegistrationPage.id,
      routes:{
        RegistrationPage.id: (context) => RegistrationPage(),
        LoginPage.id: (context) => LoginPage(),
        MainPage.id: (context) => MainPage(),
      },
    );
  }
}
