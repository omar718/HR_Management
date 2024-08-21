import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_application_2/HomePage/home.dart';
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/log-sign_in/login.dart';
import 'package:flutter_application_2/global/common/toast.dart'; // Assuming you have a custom toast function

class Signup4Screen extends StatefulWidget {
  @override
  _Signup4ScreenState createState() => _Signup4ScreenState();
}

class _Signup4ScreenState extends State<Signup4Screen> {
  String? _selectedNationality;
  PlatformFile? _cvFile;
  bool _isSubmit = false;

  final TextEditingController _cvController = TextEditingController();
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
  void dispose() {
    _cvController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      // null checks if the user selected any files or if the selection was canceled.
      // result.files.isNotEmpty ensures that there is at least one file in the list of selected files. both of them are necesseraly
      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _cvFile = result.files.first;
          _cvController.text = _cvFile!.name;
        });
      }
    } catch (e) {
      showToast(message: 'Error picking file: $e');
    }
  }

  Future<void> _submit() async {

    if (_cvFile == null || _selectedNationality==null){
      showToast(message: "Please select your nationality and upload your resume.");
      return;
    }
                          
    setState(() {
      _isSubmit = true; // Start Submit loading
    });

    try {
      // this is the reference of the location where the file will be stored
      final storageRef = FirebaseStorage.instance.ref().child('${FirebaseAuth.instance.currentUser?.uid}/${path.basename(_cvFile!.path!)}');
      
      final uploadTask = storageRef.putFile(File(_cvFile!.path!));
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();

      // Extract the file identifier from the download URL
      final uri = Uri.parse(downloadUrl);
      final filePath = uri.path; // This is the path part of the URL
      final decodedPath = Uri.decodeComponent(filePath); // Decode URL encoding
      final pathSegments = decodedPath.split('/'); // Split path by '/'
      
      // Extract the identifier from the path segments
      final fileIdentifier = pathSegments.length > 1 ? pathSegments[pathSegments.length - 2] : '';

      await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).update({
        'nationality': _selectedNationality,
        'resume': fileIdentifier,
      });

      showToast(message: "Signup successfully completed");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      showToast(message: "Error uploading file or saving data: $e");
    } finally {
      setState(() {
        _isSubmit = false; // Stop loading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/signup.png',
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Enter Your Details',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),
                DropdownButtonFormField<String>(
                  value: _selectedNationality,
                  decoration: InputDecoration(
                    labelText: 'Select Nationality',
                    labelStyle: const TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan),
                    ),
                    prefixIcon: const Icon(Icons.public, color: Colors.cyan),
                  ),
                  items: _nationalities
                      .map((nationality) => DropdownMenuItem<String>(
                            value: nationality['name'],
                            child: Row(
                              children: [
                                Text(
                                  nationality['flag']!,
                                  style: const TextStyle(fontSize: 18),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  nationality['name']!,
                                  style: TextStyle(
                                    color: _selectedNationality ==
                                            nationality['name']
                                        ? Colors.black
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedNationality = value;
                    });
                  },
                  isExpanded: true,
                  selectedItemBuilder: (BuildContext context) {
                    return _nationalities.map<Widget>((nationality) {
                      return Row(
                        children: [
                          Text(
                            nationality['flag']!,
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            nationality['name']!,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ],
                      );
                    }).toList();
                  },
                ),
                const SizedBox(height: 20.0),
                GestureDetector(
                  onTap: _pickFile, // Opens file picker when text field is tapped
                  child: AbsorbPointer(
                    child: TextField(
                      controller: _cvController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Upload CV',
                        labelStyle: const TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyan),
                        ),
                        prefixIcon: const Icon(Icons.attach_file, color: Colors.cyan),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.file_upload, color: Colors.cyan),
                          onPressed: _pickFile, // Also triggers file picker
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Go back
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.arrow_back, color: Colors.black),
                            SizedBox(width: 8.0),
                            Text(
                              'Back',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20.0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _isSubmit ? null : _submit, // Show loading indicator if in progress
                        child: _isSubmit
                          ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                        : Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Submit',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(width: 8.0),
                            Icon(Icons.send, color: Colors.white),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan,
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
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
                      child: const Text(
                        "Sign in",
                        style: TextStyle(
                          color: Colors.cyan,
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
