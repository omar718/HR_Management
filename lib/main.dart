import 'dart:io';
import 'package:firebase_core/firebase_core.dart'; //Initializes Firebase in the app.
import 'package:flutter/material.dart'; // Provides material design widgets and themes.
import 'package:flutter/services.dart';
import 'package:flutter_application_2/screens/landing_page.dart';

Future main() async { //Future main() async { ... }: The entry point of the Flutter app. It's an async function because
                      // it needs to await Firebase initialization.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
      Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,  
    ));
    return MaterialApp(
      
      title: '',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        platform: TargetPlatform.android, 
      ),
      home: LandingPage(),
    );
  }

}