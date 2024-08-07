import 'package:firebase_core/firebase_core.dart'; //Initializes Firebase in the app.
import 'package:flutter/material.dart'; // Provides material design widgets and themes.
import 'package:flutter/foundation.dart';// Offers foundational Flutter library support, including constants like kIsWeb.
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Authentication, allowing you to log users in and out.
import 'package:flutter_application_2/features/app/splash_screen/splash_screen.dart'; //Custom file
import 'package:flutter_application_2/features/user_auth/presentation/pages/home.dart';
import 'package:flutter_application_2/features/user_auth/presentation/pages/login.dart';
import 'package:flutter_application_2/features/user_auth/presentation/pages/signup.dart';
import 'package:flutter_application_2/features/user_auth/presentation/pages/additional_info.dart';


Future main() async { //Future main() async { ... }: The entry point of the Flutter app. It's an async function because
                      // it needs to await Firebase initialization.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase',
      routes: {
        '/': (context) => SplashScreen(
          // Here, you can decide whether to show the LoginPage or HomePage based on user authentication
          child: LoginPage(),
        ),
        '/login': (context) => LoginPage(),
        '/signUp': (context) => SignUpPage(),
        '/home': (context) => HomePage(),
        '/additional':(context) => AdditionalInfoPage(),
      },
    );
  }
}
