import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_2/global/common/toast.dart';
import 'package:flutter/material.dart';
import 'signup3.dart'; // Import the signup3 screen
import 'signup.dart'; // Import the signup1 screen for the back button
import 'login.dart';

class SignupScreen2 extends StatefulWidget {
  @override
  _SignupScreen2State createState() => _SignupScreen2State();
}

class _SignupScreen2State extends State<SignupScreen2> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  // Method to save user data to Firestore
  Future<void> _saveUserData() async {
    String firstName = _firstNameController.text.trim();
    String lastName = _lastNameController.text.trim();
    User? user = FirebaseAuth.instance.currentUser;

    if (firstName.isEmpty || lastName.isEmpty) {
      // Show an error message if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter your first and last name'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (user != null) {
      try {
        // Update user data in Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'firstName': firstName,
          'lastName': lastName,
        });

        // Navigate to the next screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Signup3Screen(),
          ),
        );

        showToast(message: "Data saved successfully"); // Custom toast
      } catch (e) {
        showToast(message: "Failed to save data: $e");
      }
    } else {
      showToast(message: "User not logged in");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'assets/images/signup.png', // Ensure the path to the image is correct
                  width: 100,
                  height: 100,
                ),
                SizedBox(height: 20.0),
                Text(
                  'Enter Your Details',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25.0),
                TextField(
                  controller: _firstNameController,
                  cursorColor: Colors.cyan, // Cursor color
                  decoration: InputDecoration(
                    labelText: 'First Name',
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
                    prefixIcon: Icon(Icons.person, color: Colors.cyan), // Icon color
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _lastNameController,
                  cursorColor: Colors.cyan, // Cursor color
                  decoration: InputDecoration(
                    labelText: 'Last Name',
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
                    prefixIcon: Icon(Icons.person, color: Colors.cyan), // Icon color
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Go back to the previous screen
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.arrow_back, color: Colors.black),
                            SizedBox(width: 8.0),
                            Text(
                              'Back',
                              style: TextStyle(
                                color: Colors.black, // Text color
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300], // Button background color
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
                        onPressed: _saveUserData, // Save data and proceed to the next step
                        child: Row(
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
                        Navigator.pop(context);
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
