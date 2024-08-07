import 'package:flutter/material.dart';
import 'package:flutter_application_2/log-sign_in/login.dart'; // Adjust the import based on your file structure

class NewPasswordScreen extends StatefulWidget {
  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _hasError = false;
  bool _obscureText = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _validateAndSubmit() {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text == _confirmPasswordController.text) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else {
        setState(() {
          _hasError = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/password.png', // Ensure the path to the image is correct
                  width: 100,
                  height: 100,
                ),
                SizedBox(height: 20),
                Text(
                  'Create a New Password',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscureText,
                  cursorColor: Colors.cyan, // Cursor color
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    labelStyle: TextStyle(color: Colors.grey), // Default label color
                    floatingLabelStyle: TextStyle(color: Colors.cyan), // Focused label color
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]!), // Default border color
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]!), // Enabled border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]!), // Focused border color
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureText,
                  cursorColor: Colors.cyan, // Cursor color
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(color: Colors.grey), // Default label color
                    floatingLabelStyle: TextStyle(color: Colors.cyan), // Focused label color
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]!), // Default border color
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]!), // Enabled border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]!), // Focused border color
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                if (_hasError)
                  Text(
                    'Passwords do not match',
                    style: TextStyle(color: Colors.red),
                  ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _validateAndSubmit,
                  child: Text('Confirm Password'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    foregroundColor: Colors.white, // Set text color to white
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
        ),
      ),
    );
  }
}
