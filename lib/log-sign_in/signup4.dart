import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/log-sign_in/login.dart';
import 'package:flutter_application_2/global/common/toast.dart';

class Signup4Screen extends StatefulWidget {
  @override
  _Signup4ScreenState createState() => _Signup4ScreenState();
}

class _Signup4ScreenState extends State<Signup4Screen> {
  String? _selectedNationality;
  PlatformFile? _cvFile;
  bool _isSubmitting = false; // Add this line

  final List<Map<String, String>> _nationalities = [
{'name': 'Afghanistan', 'flag': '🇦🇫'},
    {'name': 'Albania', 'flag': '🇦🇱'},
    {'name': 'Algeria', 'flag': '🇩🇿'},
    {'name': 'Andorra', 'flag': '🇦🇩'},
    {'name': 'Angola', 'flag': '🇦🇴'},
    {'name': 'Antigua and Barbuda', 'flag': '🇦🇬'},
    {'name': 'Argentina', 'flag': '🇦🇷'},
    {'name': 'Armenia', 'flag': '🇦🇲'},
    {'name': 'Australia', 'flag': '🇦🇺'},
    {'name': 'Austria', 'flag': '🇦🇹'},
    {'name': 'Azerbaijan', 'flag': '🇦🇿'},
    {'name': 'Bahamas', 'flag': '🇧🇸'},
    {'name': 'Bahrain', 'flag': '🇧🇭'},
    {'name': 'Bangladesh', 'flag': '🇧🇩'},
    {'name': 'Barbados', 'flag': '🇧🇧'},
    {'name': 'Belarus', 'flag': '🇧🇾'},
    {'name': 'Belgium', 'flag': '🇧🇪'},
    {'name': 'Belize', 'flag': '🇧🇿'},
    {'name': 'Benin', 'flag': '🇧🇯'},
    {'name': 'Bhutan', 'flag': '🇧🇹'},
    {'name': 'Bolivia', 'flag': '🇧🇴'},
    {'name': 'Bosnia and Herzegovina', 'flag': '🇧🇦'},
    {'name': 'Botswana', 'flag': '🇧🇼'},
    {'name': 'Brazil', 'flag': '🇧🇷'},
    {'name': 'Brunei', 'flag': '🇧🇳'},
    {'name': 'Bulgaria', 'flag': '🇧🇬'},
    {'name': 'Burkina Faso', 'flag': '🇧🇫'},
    {'name': 'Burundi', 'flag': '🇧🇮'},
    {'name': 'Cabo Verde', 'flag': '🇨🇻'},
    {'name': 'Cambodia', 'flag': '🇰🇭'},
    {'name': 'Cameroon', 'flag': '🇨🇲'},
    {'name': 'Canada', 'flag': '🇨🇦'},
    {'name': 'Central African Republic', 'flag': '🇨🇫'},
    {'name': 'Chad', 'flag': '🇹🇩'},
    {'name': 'Chile', 'flag': '🇨🇱'},
    {'name': 'China', 'flag': '🇨🇳'},
    {'name': 'Colombia', 'flag': '🇨🇴'},
    {'name': 'Comoros', 'flag': '🇰🇲'},
    {'name': 'Congo, Democratic Republic of the', 'flag': '🇨🇩'},
    {'name': 'Congo, Republic of the', 'flag': '🇨🇬'},
    {'name': 'Costa Rica', 'flag': '🇨🇷'},
    {'name': 'Croatia', 'flag': '🇭🇷'},
    {'name': 'Cuba', 'flag': '🇨🇺'},
    {'name': 'Cyprus', 'flag': '🇨🇾'},
    {'name': 'Czech Republic', 'flag': '🇨🇿'},
    {'name': 'Denmark', 'flag': '🇩🇰'},
    {'name': 'Djibouti', 'flag': '🇯🇵'},
    {'name': 'Dominica', 'flag': '🇩🇲'},
    {'name': 'Dominican Republic', 'flag': '🇩🇴'},
    {'name': 'Ecuador', 'flag': '🇪🇨'},
    {'name': 'Egypt', 'flag': '🇪🇬'},
    {'name': 'El Salvador', 'flag': '🇸🇻'},
    {'name': 'Equatorial Guinea', 'flag': '🇲🇶'},
    {'name': 'Eritrea', 'flag': '🇪🇷'},
    {'name': 'Estonia', 'flag': '🇪🇪'},
    {'name': 'Eswatini', 'flag': '🇸🇿'},
    {'name': 'Ethiopia', 'flag': '🇪🇹'},
    {'name': 'Fiji', 'flag': '🇫🇯'},
    {'name': 'Finland', 'flag': '🇫🇮'},
    {'name': 'France', 'flag': '🇫🇷'},
    {'name': 'Gabon', 'flag': '🇲🇬'},
    {'name': 'Gambia', 'flag': '🇲🇬'},
    {'name': 'Georgia', 'flag': '🇬🇪'},
    {'name': 'Germany', 'flag': '🇩🇪'},
    {'name': 'Ghana', 'flag': '🇬🇭'},
    {'name': 'Greece', 'flag': '🇬🇷'},
    {'name': 'Grenada', 'flag': '🇬🇩'},
    {'name': 'Guatemala', 'flag': '🇵🇪'},
    {'name': 'Guinea', 'flag': '🇲🇬'},
    {'name': 'Guinea-Bissau', 'flag': '🇬🇳'},
    {'name': 'Guyana', 'flag': '🇬🇾'},
    {'name': 'Haiti', 'flag': '🇭🇹'},
    {'name': 'Honduras', 'flag': '🇭🇳'},
    {'name': 'Hungary', 'flag': '🇭🇺'},
    {'name': 'Iceland', 'flag': '🇮🇸'},
    {'name': 'India', 'flag': '🇮🇳'},
    {'name': 'Indonesia', 'flag': '🇮🇩'},
    {'name': 'Iran', 'flag': '🇮🇷'},
    {'name': 'Iraq', 'flag': '🇮🇶'},
    {'name': 'Ireland', 'flag': '🇮🇪'},
    {'name': 'Italy', 'flag': '🇮🇹'},
    {'name': 'Jamaica', 'flag': '🇯🇲'},
    {'name': 'Japan', 'flag': '🇯🇵'},
    {'name': 'Jordan', 'flag': '🇯🇴'},
    {'name': 'Kazakhstan', 'flag': '🇰🇿'},
    {'name': 'Kenya', 'flag': '🇰🇪'},
    {'name': 'Kiribati', 'flag': '🇰🇳'},
    {'name': 'Korea, North', 'flag': '🇰🇵'},
    {'name': 'Korea, South', 'flag': '🇰🇷'},
    {'name': 'Kosovo', 'flag': '🇽🇰'},
    {'name': 'Kuwait', 'flag': '🇰🇼'},
    {'name': 'Kyrgyzstan', 'flag': '🇰🇬'},
    {'name': 'Laos', 'flag': '🇱🇦'},
    {'name': 'Latvia', 'flag': '🇱🇻'},
    {'name': 'Lebanon', 'flag': '🇱🇧'},
    {'name': 'Lesotho', 'flag': '🇱🇸'},
    {'name': 'Liberia', 'flag': '🇱🇸'},
    {'name': 'Libya', 'flag': '🇱🇾'},
    {'name': 'Liechtenstein', 'flag': '🇱🇮'},
    {'name': 'Lithuania', 'flag': '🇱🇹'},
    {'name': 'Luxembourg', 'flag': '🇱🇺'},
    {'name': 'Madagascar', 'flag': '🇲🇬'},
    {'name': 'Malawi', 'flag': '🇲🇼'},
    {'name': 'Malaysia', 'flag': '🇲🇾'},
    {'name': 'Maldives', 'flag': '🇲🇻'},
    {'name': 'Mali', 'flag': '🇲🇱'},
    {'name': 'Malta', 'flag': '🇲🇹'},
    {'name': 'Marshall Islands', 'flag': '🇲🇭'},
    {'name': 'Mauritania', 'flag': '🇲🇷'},
    {'name': 'Mauritius', 'flag': '🇲🇺'},
    {'name': 'Mexico', 'flag': '🇲🇽'},
    {'name': 'Micronesia', 'flag': '🇫🇲'},
    {'name': 'Moldova', 'flag': '🇲🇩'},
    {'name': 'Monaco', 'flag': '🇲🇨'},
    {'name': 'Mongolia', 'flag': '🇲🇳'},
    {'name': 'Montenegro', 'flag': '🇲🇪'},
    {'name': 'Morocco', 'flag': '🇲🇦'},
    {'name': 'Mozambique', 'flag': '🇲🇿'},
    {'name': 'Myanmar', 'flag': '🇲🇲'},
    {'name': 'Namibia', 'flag': '🇳🇦'},
    {'name': 'Nauru', 'flag': '🇳🇷'},
    {'name': 'Nepal', 'flag': '🇳🇵'},
    {'name': 'Netherlands', 'flag': '🇳🇱'},
    {'name': 'New Zealand', 'flag': '🇳🇿'},
    {'name': 'Nicaragua', 'flag': '🇳🇮'},
    {'name': 'Niger', 'flag': '🇳🇪'},
    {'name': 'Nigeria', 'flag': '🇳🇬'},
    {'name': 'North Macedonia', 'flag': '🇲🇰'},
    {'name': 'Norway', 'flag': '🇳🇴'},
    {'name': 'Oman', 'flag': '🇴🇲'},
    {'name': 'Pakistan', 'flag': '🇵🇰'},
    {'name': 'Palau', 'flag': '🇵🇼'},
    {'name': 'Palestine', 'flag': '🇵🇸'},
    {'name': 'Panama', 'flag': '🇵🇦'},
    {'name': 'Papua New Guinea', 'flag': '🇵🇬'},
    {'name': 'Paraguay', 'flag': '🇵🇾'},
    {'name': 'Peru', 'flag': '🇵🇪'},
    {'name': 'Philippines', 'flag': '🇵🇭'},
    {'name': 'Poland', 'flag': '🇵🇱'},
    {'name': 'Portugal', 'flag': '🇵🇹'},
    {'name': 'Qatar', 'flag': '🇶🇦'},
    {'name': 'Romania', 'flag': '🇷🇴'},
    {'name': 'Russia', 'flag': '🇷🇺'},
    {'name': 'Rwanda', 'flag': '🇷🇼'},
    {'name': 'Saint Kitts and Nevis', 'flag': '🇰🇳'},
    {'name': 'Saint Lucia', 'flag': '🇱🇨'},
    {'name': 'Saint Vincent and the Grenadines', 'flag': '🇻🇨'},
    {'name': 'Samoa', 'flag': '🇼🇸'},
    {'name': 'San Marino', 'flag': '🇸🇲'},
    {'name': 'Sao Tome and Principe', 'flag': '🇸🇹'},
    {'name': 'Saudi Arabia', 'flag': '🇸🇦'},
    {'name': 'Senegal', 'flag': '🇸🇳'},
    {'name': 'Serbia', 'flag': '🇷🇸'},
    {'name': 'Seychelles', 'flag': '🇸🇨'},
    {'name': 'Sierra Leone', 'flag': '🇸🇱'},
    {'name': 'Singapore', 'flag': '🇸🇬'},
    {'name': 'Slovakia', 'flag': '🇸🇰'},
    {'name': 'Slovenia', 'flag': '🇸🇮'},
    {'name': 'Solomon Islands', 'flag': '🇸🇧'},
    {'name': 'Somalia', 'flag': '🇸🇴'},
    {'name': 'South Africa', 'flag': '🇿🇦'},
    {'name': 'South Sudan', 'flag': '🇸🇸'},
    {'name': 'Spain', 'flag': '🇪🇸'},
    {'name': 'Sri Lanka', 'flag': '🇱🇰'},
    {'name': 'Sudan', 'flag': '🇸🇩'},
    {'name': 'Suriname', 'flag': '🇸🇷'},
    {'name': 'Sweden', 'flag': '🇸🇪'},
    {'name': 'Switzerland', 'flag': '🇨🇭'},
    {'name': 'Syria', 'flag': '🇸🇾'},
    {'name': 'Taiwan', 'flag': '🇹🇼'},
    {'name': 'Tajikistan', 'flag': '🇹🇯'},
    {'name': 'Tanzania', 'flag': '🇹🇿'},
    {'name': 'Thailand', 'flag': '🇹🇭'},
    {'name': 'Timor-Leste', 'flag': '🇹🇱'},
    {'name': 'Togo', 'flag': '🇹🇬'},
    {'name': 'Tonga', 'flag': '🇹🇴'},
    {'name': 'Trinidad and Tobago', 'flag': '🇹🇹'},
    {'name': 'Tunisia', 'flag': '🇹🇳'},
    {'name': 'Turkey', 'flag': '🇹🇷'},
    {'name': 'Turkmenistan', 'flag': '🇹🇲'},
    {'name': 'Tuvalu', 'flag': '🇹🇻'},
    {'name': 'Uganda', 'flag': '🇺🇬'},
    {'name': 'Ukraine', 'flag': '🇺🇦'},
    {'name': 'United Arab Emirates', 'flag': '🇦🇪'},
    {'name': 'United Kingdom', 'flag': '🇬🇧'},
    {'name': 'United States', 'flag': '🇺🇸'},
    {'name': 'Uruguay', 'flag': '🇺🇾'},
    {'name': 'Uzbekistan', 'flag': '🇺🇿'},
    {'name': 'Vanuatu', 'flag': '🇻🇺'},
    {'name': 'Vatican City', 'flag': '🇻🇦'},
    {'name': 'Venezuela', 'flag': '🇻🇪'},
    {'name': 'Vietnam', 'flag': '🇻🇳'},
    {'name': 'Yemen', 'flag': '🇾🇪'},
    {'name': 'Zambia', 'flag': '🇿🇲'},
    {'name': 'Zimbabwe', 'flag': '🇿🇼'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up Step 4'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(
                child: Image(
                  image: AssetImage('assets/images/signup.png'),
                  height: 150,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Please select your nationality and upload your CV:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nationality',
                ),
                value: _selectedNationality,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedNationality = newValue;
                  });
                },
                items: _nationalities.map((nationality) {
                  return DropdownMenuItem<String>(
                    value: nationality['name'],
                    child: Row(
                      children: [
                        Text(
                          nationality['flag']!,
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          nationality['name']!,
                          style: TextStyle(
                            color: _selectedNationality == nationality['name']
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => _pickFile(),
                icon: const Icon(Icons.upload_file),
                label: Text(_cvFile != null ? 'CV Selected' : 'Upload CV'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isSubmitting
                    ? null
                    : () async {
                        if (_selectedNationality != null && _cvFile != null) {
                          setState(() {
                            _isSubmitting = true; // Set to true when submitting
                          });
                          await _uploadFile();
                          setState(() {
                            _isSubmitting = false; // Set to false when done
                          });
                        } else {
                          showToast(message: "Please fill out all fields.");
                        }
                      },
                child: _isSubmitting
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(),
                      )
                    : const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickFile() async {
    try {
      // Pick a file using the FilePicker package
      final result = await FilePicker.platform.pickFiles();

      if (result != null && result.files.isNotEmpty) {
        // Get the selected file
        setState(() {
          _cvFile = result.files.first;
        });
      } else {
        // Handle case when no file is selected
        showToast(message: "No file selected.");
      }
    } catch (e) {
      // Handle any errors
      showToast(message: "Error picking file: $e");
    }
  }

  Future<void> _uploadFile() async {
    if (_cvFile == null) return;

    try {
      // Create a reference to the Firebase Storage location
      final storageRef = FirebaseStorage.instance.ref().child('${FirebaseAuth.instance.currentUser?.uid}/${path.basename(_cvFile!.path!)}');

      // Upload the file to Firebase Storage
      final uploadTask = storageRef.putFile(File(_cvFile!.path!));

      // Monitor upload progress
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        final progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
        print('Upload progress: $progress%');
      });

      // Wait for the upload to complete
      final snapshot = await uploadTask;

      // Get the download URL of the uploaded file
      final downloadUrl = await snapshot.ref.getDownloadURL();

      // Save the nationality and CV URL to Firestore
      await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).set({
        'nationality': _selectedNationality,
        'cvUrl': downloadUrl,
      }, SetOptions(merge: true));

      // Show success message and navigate to the login screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Form submitted successfully!")),
      );

      // Navigate to the login screen and replace the current screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      showToast(message: "Error uploading file or saving data: $e");
    }
  }
}
