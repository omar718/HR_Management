import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/features/user_auth/presentation/widgets/form_container_widget.dart';
import 'package:flutter_application_2/global/common/toast.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class AdditionalInfoPage extends StatefulWidget {
  const AdditionalInfoPage({super.key});

  @override
  State<AdditionalInfoPage> createState() => _AdditionalInfoPageState();
}

class _AdditionalInfoPageState extends State<AdditionalInfoPage> {
  bool isUploading = false;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dateOfBirthController.dispose();
    _nationalityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Additional Information"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Additional Information",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              _buildTextField(controller: _firstNameController, hintText: "First Name"),
              SizedBox(height: 10),
              _buildTextField(controller: _lastNameController, hintText: "Last Name"),
              SizedBox(height: 10),
              _buildTextField(controller: _dateOfBirthController, hintText: "Date of Birth"),
              SizedBox(height: 10),
              _buildTextField(controller: _nationalityController, hintText: "Nationality"),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  _saveAdditionalInfo();
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: isUploading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            "Save",
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

  Widget _buildTextField({required TextEditingController controller, required String hintText}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
    );
  }

  Future<void> _saveAdditionalInfo() async {
    setState(() {
      isUploading = true;
    });

    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String dateOfBirth = _dateOfBirthController.text;
    String nationality = _nationalityController.text;

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        showToast(message: "No user signed in");
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
        return;
      }

      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'firstName': firstName,
        'lastName': lastName,
        'dateOfBirth': dateOfBirth,
        'nationality': nationality,
      });

      showToast(message: "Additional information saved successfully");
      Navigator.pushReplacementNamed(context, '/home');
      
    } catch (e) {
      showToast(message: "Error: $e");
    } finally {
      setState(() {
        isUploading = false;
      });
    }
  }
}