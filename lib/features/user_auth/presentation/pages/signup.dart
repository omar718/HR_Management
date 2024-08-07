import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/features/user_auth/presentation/widgets/form_container_widget.dart';
import 'package:flutter_application_2/global/common/toast.dart';
import 'package:flutter_application_2/features/user_auth/presentation/pages/additional_info.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isSigningUp = false;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
//frontend
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Sign Up"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign Up",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              FormContainerWidget(
                controller: _emailController,
                hintText: "Email",
                isPasswordField: false,
              ),
              SizedBox(height: 10),
              FormContainerWidget(
                controller: _passwordController,
                hintText: "Password",
                isPasswordField: true,
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  _signUp();
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: _isSigningUp
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
//backend
  void _signUp() async {
    setState(() {
      _isSigningUp = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword( 
        email: email,
        password: password,
      );
      User? user = userCredential.user;

    if (user != null) {
      // Create a new document for the user
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'email': email,
        // Initialize with basic data, can be expanded later
        'firstName': '',
        'lastName': '',
        'dateOfBirth': '',
        'nationality': '',
      });
      // User successfully signed up
      showToast(message: "Sign up successful");

      // Navigate to AdditionalInfoPage
      Navigator.pushReplacementNamed(context, '/additional');
    }
    } catch (e) {
      // Handle sign-up errors
      showToast(message: "Sign up failed: $e");
    } finally {
      setState(() {
        _isSigningUp = false;
      });
    }
  }
}