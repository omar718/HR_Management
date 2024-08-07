import 'package:flutter/material.dart';
import 'package:flutter_application_2/log-sign_in/login.dart';
import 'pincode.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _isButtonDisabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.jpg', // Ensure the path to the image is correct
              width: 100,
              height: 100,
            ),
            SizedBox(height: 20.0),
            Text(
              'Forgot Your Password?',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Enter your email to receive a PIN code to reset your password.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 40.0),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyan),
                ),
                prefixIcon: Icon(Icons.email, color: Colors.cyan),
                floatingLabelStyle: TextStyle(color: Colors.cyan),
              ),
              cursorColor: Colors.cyan, // Cursor color
            ),
            SizedBox(height: 20.0),
            TextButton(
              onPressed: _isButtonDisabled
                  ? null
                  : () {
                      // Handle send PIN code logic here
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PinCodeScreen(), // Navigate to ForgotPasswordScreen
                        ),
                      );

                      String email = _emailController.text;

                      // Disable button while processing
                      setState(() {
                        _isButtonDisabled = true;
                      });

                      // Simulate sending the PIN code (replace with actual implementation)
                      Future.delayed(Duration(seconds: 2), () {
                        // After processing, enable the button again
                        setState(() {
                          _isButtonDisabled = false;
                        });

                        // Show a snackbar or alert dialog to confirm email
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('PIN code sent to $email'),
                          ),
                        );
                      });
                    },
              child: Text(
                "Get PIN Code",
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 0.5,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.cyan, // Changed to cyan
                padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 80),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
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
    );
  }
}