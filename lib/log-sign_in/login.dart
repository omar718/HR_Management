import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/HomePage/home.dart';
import 'package:flutter_application_2/log-sign_in/ForgotPasswordScreen.dart';
import 'package:flutter_application_2/global/common/toast.dart';
import 'signup.dart'; // Import the signup screen

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _obscureText = true; // For hiding/showing password
  bool _isLoading = false; // For showing a loading indicator during login

  void _login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showToast(message: "Please fill in all fields");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Perform login with Firebase Authentication
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // Navigate to HomePage if login is successful
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
        showToast(message: "Login successful");
      }
    } catch (e) {
      // Handle login errors
      showToast(message: "Error: ${e.toString()}");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50.0), // Adjust the height to center the content
                Image.asset(
                  'assets/images/logo.jpg', // Ensure the path to the image is correct
                  width: 100,
                  height: 100,
                ),
                SizedBox(height: 20.0),
                Text(
                  'Login to your account',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 50.0),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.cyan, // Cursor color
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.grey), // Default label color
                    floatingLabelStyle: TextStyle(color: Colors.cyan), // Focused label color
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan), // Focused border color
                    ),
                    prefixIcon: Icon(Icons.email, color: Colors.cyan), // Icon color
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _passwordController,
                  obscureText: _obscureText,
                  cursorColor: Colors.cyan, // Cursor color
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.grey), // Default label color
                    floatingLabelStyle: TextStyle(color: Colors.cyan), // Focused label color
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan), // Focused border color
                    ),
                    prefixIcon: Icon(Icons.lock, color: Colors.cyan), // Icon color
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.cyan,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _isLoading ? null : _login, // Disable button when loading
                  child: _isLoading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white, // Change the text color to white
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Icon(Icons.login, color: Colors.white),
                          ],
                        ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    textStyle: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ForgotPasswordScreen(), // Navigate to ForgotPasswordScreen
                      ),
                    );
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        color: Colors.grey,
                        letterSpacing: 0.5,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SignupScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                          color: Colors.cyan, // Changed to cyan
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50.0), // Extra space at the bottom
              ],
            ),
          ),
        ),
      ),
    );
  }
}
