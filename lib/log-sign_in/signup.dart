import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/global/common/toast.dart'; // Import your custom toast function
import 'package:flutter_application_2/features/user_auth/firebase_auth/firebase_auth.dart'; // Import your custom auth function
import 'signup2.dart'; // Import the second signup screen
import 'login.dart'; // Import the login screen
import 'package:flutter_application_2/HomePage/home.dart'; // Home page import

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final FirebaseAuthService _auth = FirebaseAuthService();
// managing the state of the input fields
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;
  bool _isSigningUp = false;

  @override
  void dispose() { // dispose helps release resources and clean up listeners.
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }  
    bool _isValidEmail(String email) {
    final regular_expression = RegExp(r'^[^@]+@[^@]+\.[^@]+$'); // RegExp is a method used in dart to evaluate regular expressions
    return regular_expression.hasMatch(email);
  }

  // Method to sign up the user
  void _signUp() async {
      String email = _emailController.text.trim(); // trim method is used to remove unintended spaces
      String password = _passwordController.text.trim();
      String confirmPassword = _confirmPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      showToast(message: "Please fill out all fields.");
      return;
    }
    
    if (!_isValidEmail(email)) {
      showToast(message: "Invalid email address.");
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      // Show an error message if passwords do not match
      showToast(message: "Passwords don't match"); // Custom toast
      return;
    }

    setState(() {
      _isSigningUp = true;
    });

    try {
      // Create a new user with Firebase Auth
      User? user = await _auth.signUpWithEmailAndPassword(email, password);
      if (user != null) {
        // Store initial data in Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': email,
          'firstName': '',
          'lastName': '',
          'dateOfBirth': '',
          'nationality': '',
          'role':'guest',
          'picture':'',
          'resume':'',
          'appliedJobs':'',
          'interviewPlanned':'',
          'tasks':'',
          'acceptedJobs':'',
        });

        // Navigate to SignupScreen2 for additional info
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SignupScreen2(),
          ),
        );

        showToast(message: "Sign up successful"); // Custom toast
      }
    } catch (e) {
      // Show error message if sign-up fails
      showToast(message: "Sign up failed: $e");
    } finally {
      setState(() {
        _isSigningUp = false; // Hide the loading indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/signup.png', // Ensure the path to the image is correct
                  width: 100,
                  height: 100,
                ),
                SizedBox(height: 20.0),
                Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25.0),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.cyan, // Cursor color
                  decoration: InputDecoration(
                    labelText: 'Email Address',
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
                  obscureText: _obscureTextPassword,
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
                        _obscureTextPassword ? Icons.visibility : Icons.visibility_off,
                        color: Colors.cyan,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureTextPassword = !_obscureTextPassword;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureTextConfirmPassword,
                  cursorColor: Colors.cyan, // Cursor color
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
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
                        _obscureTextConfirmPassword ? Icons.visibility : Icons.visibility_off,
                        color: Colors.cyan,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
                        });
                      },
                    ),
                  ),
                ),
              SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {Navigator.of(context).push(
                          MaterialPageRoute( 
                            builder: (context) => HomePage(),
                          ),
                        );
                      },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.home, color: Colors.white),
                            SizedBox(width: 8.0),
                            Text(
                              'Home',
                              style: TextStyle(
                                color: Colors.white, // Text color
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, // Button background color
                          foregroundColor: Colors.black, // Button text color
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0), // Rounded corners
                          ),
                          textStyle: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0), // Space between buttons
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _isSigningUp ? null : _signUp, // Disable button if signing up
                        child: _isSigningUp
                          ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                        : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Next',
                              style: TextStyle(
                                color: Colors.white, // Change the text color to white
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Icon(Icons.arrow_forward, color: Colors.white),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan, // Button background color
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          textStyle: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),                
                SizedBox(height: 40.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Want to try again? ",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        letterSpacing: 0.5,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Sign in",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
