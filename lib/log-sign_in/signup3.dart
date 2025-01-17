import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // Internationalization package used for date and time formatting 
import 'package:flutter_application_2/global/common/toast.dart';
import 'login.dart';
import 'signup4.dart';

class Signup3Screen extends StatefulWidget {
  @override
  _Signup3ScreenState createState() => _Signup3ScreenState();
}

class _Signup3ScreenState extends State<Signup3Screen> {
  DateTime? _selectedDate;
  String? _selectedGender;
  final _dateController = TextEditingController();

  // Function to select a date from the date picker
  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      // Calculate the date 18 years ago from today
      final DateTime eighteenYearsAgo = DateTime.now().subtract(Duration(days: 365 * 18));

      if (picked.isAfter(eighteenYearsAgo)) {
        // Show an error message if the user is not at least 18
        showToast(message: "You must be at least 18 years old"); // Custom toast
        return;
      }

      setState(() {
        _selectedDate = picked;
        // Format the date to DD-MM-YYYY
        final formattedDate = DateFormat('dd-MM-yyyy').format(picked);
        _dateController.text = formattedDate;
      });
    }
  }

  // Method to save user data to Firestore
  Future<void> _saveUserData() async {
    // Check if gender or date of birth is not selected
    if (_selectedGender == null || _selectedDate == null) {
      showToast(message: "Please select your gender and date of birth"); // Custom toast
      return; // Exit the function to prevent navigation
    }

    // Calculate the date 18 years ago from today
    final DateTime eighteenYearsAgo = DateTime.now().subtract(Duration(days: 365 * 18));
    
    // Check if the user is under 18
    if (_selectedDate!.isAfter(eighteenYearsAgo)) {
      showToast(message: "You must be at least 18 years old"); // Custom toast
      return; // Exit the function to prevent navigation
    }

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        // Update user data in Firestore
        final formattedDate = DateFormat('dd-MM-yyyy').format(_selectedDate!);
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'gender': _selectedGender,
          'dateOfBirth': formattedDate,
        });

      // Navigate to the next screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Signup4Screen(),
        ),
      );
    } catch (e) {
      showToast(message: "Failed to save data: $e");
    }
  } else {
    showToast(message: "User not logged in");
    return; // Exit the function to prevent navigation
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
                  'Enter Your Details',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ChoiceChip(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.male, color: Colors.white),
                          SizedBox(width: 8.0),
                          Text('Male'),
                        ],
                      ),
                      selected: _selectedGender == 'Male',
                      onSelected: (selected) {
                        setState(() {
                          _selectedGender = selected ? 'Male' : null;
                        });
                      },
                      selectedColor: Colors.blue,
                      backgroundColor: Colors.grey[300],
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    SizedBox(width: 20.0),
                    ChoiceChip(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.female, color: Colors.white),
                          SizedBox(width: 8.0),
                          Text('Female'),
                        ],
                      ),
                      selected: _selectedGender == 'Female',
                      onSelected: (selected) {
                        setState(() {
                          _selectedGender = selected ? 'Female' : null;
                        });
                      },
                      selectedColor: Colors.pink,
                      backgroundColor: Colors.grey[300],
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: _dateController,
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  decoration: InputDecoration(
                    labelText: 'Date of Birth',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    prefixIcon: Icon(Icons.calendar_today, color: Colors.cyan),
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
                        color: Colors.black,
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
