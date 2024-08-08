import 'package:flutter/material.dart';
import 'package:flutter_application_2/HomePage/home.dart';
import 'package:flutter_application_2/log-sign_in/login.dart';  // Import the LoginScreen

class GetStartedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: 60.0,
      width: 200.0,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.cyan,
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          textStyle: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'GET STARTED',
              style: TextStyle(
                color: Colors.white, // Change the text color to white
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8.0),
            Icon(Icons.arrow_forward, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
