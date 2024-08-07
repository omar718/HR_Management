import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_application_2/log-sign_in/login.dart';
import 'newpasswrd.dart';  // Ensure this import is correct

class PinCodeScreen extends StatefulWidget {
  @override
  _PinCodeScreenState createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.4, 0.7, 0.9],
            colors: [
              Colors.white.withOpacity(0.8),
              Colors.white,
              Colors.white,
              Colors.white,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 500,
                  padding: EdgeInsets.all(30.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/images/pincode.jpg", // Replace with your logo image path
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Pin Code",
                        style: TextStyle(
                          color: Colors.cyan, // Changed to cyan
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Let us help you",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.9),
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Email Pin Verification',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                        child: RichText(
                          text: TextSpan(
                            text: "Enter the code sent to ",
                            children: [
                              TextSpan(
                                text: "Your Email", // Replace with actual email
                                style: TextStyle(
                                  color: Colors.cyan, // Changed to cyan
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 20),
                      Form(
                        key: formKey,
                        child: PinCodeTextField(
                          appContext: context,
                          length: 6,
                          obscureText: false,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            activeFillColor: Colors.cyan, // Changed to cyan
                            inactiveFillColor: Colors.white,
                            selectedFillColor: Colors.cyan, // Changed to cyan
                            selectedColor: Colors.cyan, // Changed to cyan
                            activeColor: Colors.cyan, // Changed to cyan
                            inactiveColor: Colors.grey[300]!,
                          ),
                          cursorColor: Colors.black,
                          animationDuration: Duration(milliseconds: 300),
                          enableActiveFill: true,
                          errorAnimationController: errorController,
                          controller: textEditingController,
                          keyboardType: TextInputType.number,
                          boxShadows: [
                            BoxShadow(
                              offset: Offset(0, 1),
                              color: Colors.black12,
                              blurRadius: 10,
                            ),
                          ],
                          onCompleted: (v) {
                            debugPrint("Completed");
                          },
                          onChanged: (value) {
                            debugPrint(value);
                            setState(() {
                              currentText = value;
                            });
                          },
                          beforeTextPaste: (text) {
                            debugPrint("Allowing to paste $text");
                            return true;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          hasError ? "*Please fill up all the cells properly" : "",
                          style: TextStyle(
                            color: Colors.red, // Changed to red for errors
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Didn't receive the code? ",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                            ),
                          ),
                          TextButton(
                            onPressed: () => snackBar("OTP resend!!"),
                            child: Text(
                              "RESEND",
                              style: TextStyle(
                                color: Colors.cyan, // Changed to cyan
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      TextButton(
                        onPressed: () {
                          formKey.currentState!.validate();
                          if (currentText.length != 6 || currentText != "123456") {
                            errorController!.add(ErrorAnimationType.shake);
                            setState(() => hasError = true);
                          } else {
                            setState(() {
                              hasError = false;
                              snackBar("OTP Verified!!");
                            });
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => NewPasswordScreen(),
                              ),
                            );
                          }
                        },
                        child: Text(
                          "Verify",
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
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Want to try again? ",
                      style: TextStyle(
                        color: Colors.grey,
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
