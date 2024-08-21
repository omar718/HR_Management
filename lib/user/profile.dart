import 'package:flutter/material.dart';
import 'package:flutter_application_2/HomePage/home.dart';
import 'package:flutter_application_2/user/home_user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:flutter_application_2/global/common/toast.dart'; // Import your custom toast function

class profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<profile> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  TextEditingController _cvController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _nationalityController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscureConfirmPassword = true;
  bool _obscurePassword = true;
  String? _selectedNationality;

  final List<Map<String, dynamic>> _nationalities = [
  {'name': 'Afghanistan', 'flag': '🇦🇫'},
  {'name': 'Albania', 'flag': '🇦🇱'},
  {'name': 'Algeria', 'flag': '🇩🇿'},
  {'name': 'Argentina', 'flag': '🇦🇷'},
  {'name': 'Australia', 'flag': '🇦🇺'},
  {'name': 'Brazil', 'flag': '🇧🇷'},
  {'name': 'Canada', 'flag': '🇨🇦'},
  {'name': 'China', 'flag': '🇨🇳'},
  {'name': 'Colombia', 'flag': '🇨🇴'},
  {'name': 'Cuba', 'flag': '🇨🇺'},
  {'name': 'Denmark', 'flag': '🇩🇰'},
  {'name': 'Egypt', 'flag': '🇪🇬'},
  {'name': 'France', 'flag': '🇫🇷'},
  {'name': 'Germany', 'flag': '🇩🇪'},
  {'name': 'Greece', 'flag': '🇬🇷'},
  {'name': 'India', 'flag': '🇮🇳'},
  {'name': 'Indonesia', 'flag': '🇮🇩'},
  {'name': 'Iran', 'flag': '🇮🇷'},
  {'name': 'Iraq', 'flag': '🇮🇶'},
  {'name': 'Italy', 'flag': '🇮🇹'},
  {'name': 'Japan', 'flag': '🇯🇵'},
  {'name': 'Jordan', 'flag': '🇯🇴'},
  {'name': 'Kuwait', 'flag': '🇰🇼'},
  {'name': 'Lebanon', 'flag': '🇱🇧'},
  {'name': 'Libya', 'flag': '🇱🇾'},
  {'name': 'Morocco', 'flag': '🇲🇦'},
  {'name': 'Oman', 'flag': '🇴🇲'},
  {'name': 'Palestine', 'flag': '🇵🇸'},
  {'name': 'Qatar', 'flag': '🇶🇦'},
  {'name': 'Saudi Arabia', 'flag': '🇸🇦'},
  {'name': 'Syria', 'flag': '🇸🇾'},
  {'name': 'Tunisia', 'flag': '🇹🇳'},
  {'name': 'United Arab Emirates', 'flag': '🇦🇪'},
  {'name': 'Yemen', 'flag': '🇾🇪'},
  {'name': 'Netherlands', 'flag': '🇳🇱'},
  {'name': 'New Zealand', 'flag': '🇳🇿'},
  {'name': 'Nigeria', 'flag': '🇳🇬'},
  {'name': 'Norway', 'flag': '🇳🇴'},
  {'name': 'Pakistan', 'flag': '🇵🇰'},
  {'name': 'Peru', 'flag': '🇵🇪'},
  {'name': 'Philippines', 'flag': '🇵🇭'},
  {'name': 'Poland', 'flag': '🇵🇱'},
  {'name': 'Russia', 'flag': '🇷🇺'},
  {'name': 'South Africa', 'flag': '🇿🇦'},
  {'name': 'South Korea', 'flag': '🇰🇷'},
  {'name': 'Spain', 'flag': '🇪🇸'},
  {'name': 'Sweden', 'flag': '🇸🇪'},
  {'name': 'Turkey', 'flag': '🇹🇷'},
  {'name': 'United Kingdom', 'flag': '🇬🇧'},
  {'name': 'United States', 'flag': '🇺🇸'},
];
  
  @override
  void initState() {
    super.initState();
    _dobController.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
  }

  File? _profileImage;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickCV() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _cvController.text = result.files.single.name;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
        _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
  }

  void _showProfilePictureOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.photo_library, color: Colors.black),
                title:
                    Text('Import Photo', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage();
                },
              ),
              ListTile(
                leading: Icon(Icons.cancel, color: Colors.black),
                title: Text('Cancel', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure you want to delete your profile?'),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                // Reset all fields
                setState(() {
                  _firstNameController.clear();
                  _lastNameController.clear();
                  _emailController.clear();
                  _confirmPasswordController.clear();
                  _nationalityController.clear();
                  _dobController.clear();
                  _passwordController.clear();
                  _cvController.clear();
                 
                });
                Navigator.of(context).pop(); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Profile deleted')),
                );
              },
            ),
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Close the dialog without doing anything
              },
            ),
          ],
        );
      },
    );
  }

  void _updateProfile() {
    if (_formKey.currentState!.validate()) {
      // Handle profile update logic here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  margin:
                      const EdgeInsets.only(top: 100), // Space for the app bar
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(0),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 255, 253, 255)
                            .withOpacity(0.2),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Update Profile',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 8),
                          Image.asset(
                            'images/update.png',
                            width: 24,
                            height: 24,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Positioned(
                              left: 20,
                              top: 165, // Adjust this value as needed
                              child: Text(
                                'Change Profile Photo',
                                style: GoogleFonts.aBeeZee(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  height: 1.2, // Line height for spacing
                                ),
                              ),
                            ),
                            // Photo de profil

                            GestureDetector(
                              onTap: _showProfilePictureOptions,
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 2,
                                      color: Color.fromARGB(168, 31, 108, 181)),
                                ),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Icon(Icons.camera_alt,
                                          size: 40,
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 12),

                            // Prénom
                            TextFormField(
                              controller: _firstNameController,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: 'First Name',
                                labelStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.8),
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  fontFamily: 'ABeeZee',
                                ),
                                filled: true,
                                fillColor: Color(0x0F387B97),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.38),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: Icon(Icons.person,
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your first name';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 12),

                            // Nom
                            TextFormField(
                              controller: _lastNameController,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: 'Last Name',
                                labelStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.8),
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  fontFamily: 'ABeeZee',
                                ),
                                filled: true,
                                fillColor: Color(0x0F387B97),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.38),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: Icon(Icons.person,
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your last name';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 12),

                            // Adresse e-mail
                            TextFormField(
                              controller: _emailController,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: 'Email Address',
                                labelStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.8),
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  fontFamily: 'ABeeZee',
                                ),
                                filled: true,
                                fillColor: Color(0x0F387B97),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.38),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: Icon(Icons.email,
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email address';
                                }
                                // Expression régulière pour valider le format de l'email
                                String emailPattern = r'^[^@]+@[^@]+\.[^@]+$';
                                RegExp emailRegex = RegExp(emailPattern);
                                if (!emailRegex.hasMatch(value)) {
                                  return 'Please enter a valid email address example@example.com';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 12),
                            //password

                            SizedBox(height: 12),
// Password
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.8),
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  fontFamily: 'ABeeZee',
                                ),
                                filled: true,
                                fillColor: Color(0x0F387B97),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.38),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: Icon(Icons.lock,
                                    color: Colors.black.withOpacity(0.6)),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (value.length < 8) {
                                  return 'Password must be at least 8 characters long';
                                }
                                // Regex to check for at least one digit, one lowercase letter, one uppercase letter, and one special character
                                String passwordPattern =
                                    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
                                RegExp passwordRegex = RegExp(passwordPattern);
                                if (!passwordRegex.hasMatch(value)) {
                                  return 'Password must include at least one uppercase letter, one lowercase letter, one number, and one special character';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 12),
// Confirm Password
                            TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: _obscureConfirmPassword,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                labelStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.8),
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  fontFamily: 'ABeeZee',
                                ),
                                filled: true,
                                fillColor: Color(0x0F387B97),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.38),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: Icon(Icons.lock,
                                    color: Colors.black.withOpacity(0.6)),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureConfirmPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureConfirmPassword =
                                          !_obscureConfirmPassword;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password';
                                }
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 12),

                            // Date de naissance
                            TextFormField(
                              controller: _dobController,
                              readOnly: true,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: 'Date of Birth',
                                labelStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.8),
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  fontFamily: 'ABeeZee',
                                ),
                                filled: true,
                                fillColor: Color(0x0F387B97),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.38),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: Icon(Icons.calendar_today,
                                    color: Colors.black.withOpacity(0.6)),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.arrow_drop_down,
                                      color: Colors.black.withOpacity(0.6)),
                                  onPressed: () {
                                    _selectDate(context);
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select your date of birth';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 12),

                            // Nationalité
                           
                             
                            DropdownButtonFormField<String>(
                              value: _selectedNationality,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedNationality = newValue;
                                });
                              },
                              
                              decoration: InputDecoration(
                                
                                labelText: 'Nationality',
                                labelStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.8),
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  fontFamily: 'ABeeZee',
                                ),
                                filled: true,
                                fillColor: Color(0x0F387B97),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.38),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: Icon(Icons.flag,
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                              items: _nationalities.map((nationality) {
                                return DropdownMenuItem<String>(
                                  value: nationality['name'],
                                  child: Row(
                                    children: [
                                      Text(nationality['flag']),
                                      SizedBox(width: 8),
                                      Text(nationality['name']),
                                    ],
                                  ),
                                );
                              }).toList(),
                              
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select your nationality';
                                }
                                return null;
                              },
                            ),
                            
                            SizedBox(height: 12),
                            TextFormField(
                              controller: _cvController,
                              readOnly: true,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: 'CV',
                                labelStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.8),
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  fontFamily: 'ABeeZee',
                                ),
                                filled: true,
                                fillColor: Color(0x0F387B97),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.38),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: Icon(Icons.attach_file,
                                    color: Colors.black.withOpacity(0.6)),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.file_upload,
                                      color: Colors.black.withOpacity(0.6)),
                                  onPressed: _pickCV,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please upload your CV';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),

                            // Boutons

                            // Boutons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Bouton bleu de confirmation
                                ElevatedButton(
                                  onPressed: _updateProfile,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    'Update Profile',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 2, 2, 2),
                                      fontSize: 18,
                                      fontFamily: 'Poly',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),

                                // Bouton rouge de suppression
                                ElevatedButton(
                                  onPressed: _showDeleteConfirmationDialog,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    'Delete Profile',
                                    style: TextStyle(
                                      color: const Color.fromARGB(255, 5, 5, 5),
                                      fontSize: 18,
                                      fontFamily: 'Poly',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 192, 224,
            240), // Couleur bleu clair pour la barre d'applications
        iconTheme: const IconThemeData(
          color:
              Colors.black, // Couleur noire pour l'icône de la barre latérale
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Colors.black), // Icône de flèche de retour noire
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeUser()),
            ); // Retourne à l'écran précédent
          },
        ),
        actions: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: PopupMenuButton<String>(
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: _profileImage == null
                          ? AssetImage('images/profil.png') as ImageProvider
                          : FileImage(_profileImage!),
                      fit: BoxFit.fill,
                    ),
                    shape: OvalBorder(
                      side: BorderSide(width: 1, color: Color(0xFF2F9BFF)),
                    ),
                  ),
                ),
                color: const Color.fromARGB(189, 106, 193,
                    227), // Couleur bleue pour le fond du menu contextuel
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Bordure circulaire
                ),
                onSelected: (String choice) async {
                  if (choice == 'Home') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  } else if (choice == 'Logout') {
                    // Sign out the user
                    await FirebaseAuth.instance.signOut();
                    showToast(message: "Successfully logged out");
                    // Navigate to the homepage
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (route) => false,
                    );
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem<String>(
                      value: 'Home',
                      child: Row(
                        children: [
                          Icon(Icons.home,
                              color: Colors.black,
                              size: 24), // Icône noire pour Accueil
                          const SizedBox(width: 8),
                          const Text(
                            'Home',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16), // Taille du texte ajustée
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'Logout',
                      child: Row(
                        children: [
                          Icon(Icons.exit_to_app,
                              color: Colors.black,
                              size: 24), // Icône noire pour Déconnexion
                          const SizedBox(width: 8),
                          const Text(
                            'Logout',
                            style: TextStyle(
                                color: Color.fromARGB(255, 132, 11, 11),
                                fontSize: 16), // Taille du texte ajustée
                          ),
                        ],
                      ),
                    ),
                  ];
                },
              ),
            ),
          ),
          const SizedBox(width: 10), // Espacement entre les icônes
        ],
      ),
    );
  }
}
