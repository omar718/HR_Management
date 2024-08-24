import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_2/HomePage/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_2/global/common/toast.dart';
import 'home_admin.dart';
import 'Offers.dart';


class PostOfferPage extends StatefulWidget {
  @override
  _PostOfferPageState createState() => _PostOfferPageState();
}

class _PostOfferPageState extends State<PostOfferPage> {
  final _jobTitleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _requirementsController = TextEditingController();
  final _locationController = TextEditingController();
  final _salaryController = TextEditingController();
  bool _isLoading = false; // Track loading state

  void _submitOffer() async{
    
    final jobTitle = _jobTitleController.text;
    final description = _descriptionController.text;
    final requirements = _requirementsController.text;
    final location = _locationController.text;
    final salary = _salaryController.text;

    // Implement your form submission logic here
    
    if (jobTitle.isEmpty || description.isEmpty || requirements.isEmpty || location.isEmpty || salary.isEmpty) {
        // Optionally show an error message if any field is empty
        showToast(message: 'Please fill all the fields');
        return;
      }
    setState(() {
          _isLoading = true; // Show loading indicator
        });
      // Save data to Firestore
      try {
        //extraction the full name of the user from the 'users' collection
        final user = FirebaseAuth.instance.currentUser;

          if (user == null) {
            print('There is a problem No user is currently signed in.'); // errror message if no one is signed up
            return;
          }

          final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
          
          if (!userDoc.exists) {
            print('User document does not exist.');
            return;
          }

          final userData = userDoc.data();
          final userID = user.uid;
          final firstName = userData?['firstName'] ?? 'Unknown';
          final lastName = userData?['lastName'] ?? 'Unknown';
          final createdBy = '$firstName $lastName';

        await FirebaseFirestore.instance.collection('jobs').add({
          'title': jobTitle,
          'description': description,
          'requirements': requirements,
          'location': location,
          'salary': salary,
          'createdBy': createdBy,
          'adminID': userID,
          'applicants':"",
          'acceptedApplicants':"",
          'status':'open'
        });

        // Clear the fields after successful submission
        _jobTitleController.clear();
        _descriptionController.clear();
        _requirementsController.clear();
        _locationController.clear();
        _salaryController.clear();

        //show a confirmation message
        showToast(message: 'New Job Offer Submitted Successfully');

      } catch (error) {
        // Optionally show an error message if something goes wrong
        showToast(message: 'Failed to post job offer: $error');
      } finally {
        setState(() {
            _isLoading = false;
          });
      }

      }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
            appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 192, 224, 240),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => homeAdmin()),
            );
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
                      image: AssetImage('images/profil.png'),
                      fit: BoxFit.fill,
                    ),
                    shape: OvalBorder(
                      side: BorderSide(width: 1, color: Color.fromARGB(70, 47, 154, 255)),
                    ),
                  ),
                ),
                color: const Color.fromARGB(189, 106, 193, 227),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
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
                          Icon(Icons.home, color: Colors.black, size: 24),
                          const SizedBox(width: 8),
                          const Text(
                            'Home',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'Logout',
                      child: Row(
                        children: [
                          Icon(Icons.exit_to_app, color: Colors.black, size: 24),
                          const SizedBox(width: 8),
                          const Text(
                            'Logout',
                            style: TextStyle(color: Color.fromARGB(255, 132, 11, 11), fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ];
                },
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Stack(children: [
        SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 396,
                  height: 852,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color.fromARGB(255, 255, 255, 255),
                        blurRadius: 25,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 76,
                        top: 130,
                        child: SizedBox(
                          width: 137,
                          child: Text(
                            'Post offer',
                            style: GoogleFonts.lexendDeca(
                              color: Color.fromARGB(255, 3, 3, 3),
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              height: 1.2, // Hauteur de ligne pour espacement
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: -30,
                        top: 200,
                        child: Container(
                          width: 423,
                          height: 496.49,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 34,
                                top: 0,
                                child: Container(
                                  width: 389,
                                  height: 414,
                                  decoration: ShapeDecoration(
                                    color: Color(0x84D9D9D9),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 30.21,
                                top: 110.56,
                                child: SizedBox(
                                  width: 119.25,
                                  height: 20.93,
                                  child: Text(
                                    'Description :  ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontFamily: 'Poly',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 250,
                                child: SizedBox(
                                  width: 177.83,
                                  height: 27.91,
                                  child: Text(
                                    'Location  :',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontFamily: 'Poly',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 153.09,
                                top: 164.64,
                                child: Container(
                                  width: 241.56,
                                  height: 55.37,
                                  child: TextFormField(
                                    controller: _requirementsController,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontFamily: 'Poly',
                                      fontWeight: FontWeight.w400,
                                    ),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: "(separate with ' , ' )",
                                      hintStyle: TextStyle(
                                        color: Color.fromARGB(62, 66, 64, 64),
                                        fontSize: 15,
                                        fontFamily: 'Poly',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                    maxLines: 1,
                                    keyboardType: TextInputType.multiline,
                                    textInputAction: TextInputAction.newline,
                                    scrollPhysics: ClampingScrollPhysics(),
                                    textAlignVertical: TextAlignVertical.center,
                                    expands: false,
                                    scrollPadding: EdgeInsets.all(0),
                                    textAlign: TextAlign.left,
                                    textCapitalization:TextCapitalization.sentences,
                                    showCursor: true,
                                    autocorrect: false,
                                    cursorColor: Colors.black,
                                    autofocus: false,
                                    enableInteractiveSelection: true,
                                    readOnly: false,
                                    scrollController: ScrollController(),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 153.09,
                                top: 95.88,
                                child: Container(
                                  width: 241.56,
                                  height: 55.37,
                                  child: TextFormField(
                                    controller: _descriptionController,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontFamily: 'Poly',
                                      fontWeight: FontWeight.w400,
                                    ),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Enter description',
                                      hintStyle: TextStyle(
                                        color: Color.fromARGB(62, 66, 64, 64),
                                        fontSize: 15,
                                        fontFamily: 'Poly',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                    maxLines: 1,
                                    keyboardType: TextInputType.multiline,
                                    textInputAction: TextInputAction.newline,
                                    scrollPhysics: ClampingScrollPhysics(),
                                    textAlignVertical: TextAlignVertical.center,
                                    expands: false,
                                    scrollPadding: EdgeInsets.all(0),
                                    textAlign: TextAlign.left,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    showCursor: true,
                                    autocorrect: false,
                                    cursorColor: Colors.black,
                                    autofocus: false,
                                    enableInteractiveSelection: true,
                                    readOnly: false,
                                    scrollController: ScrollController(),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 156.11,
                                top: 304.10,
                                child: Container(
                                  width: 241.56,
                                  height: 55.37,
                                  child: TextFormField(
                                    controller: _salaryController,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontFamily: 'Poly',
                                      fontWeight: FontWeight.w400,
                                    ),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Enter salary in TND',
                                      hintStyle: TextStyle(
                                        color: Color.fromARGB(62, 66, 64, 64),
                                        fontSize: 15,
                                        fontFamily: 'Poly',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                    maxLines: 1,
                                    keyboardType: TextInputType.multiline,
                                    textInputAction: TextInputAction.newline,
                                    scrollPhysics: ClampingScrollPhysics(),
                                    textAlignVertical: TextAlignVertical.center,
                                    expands: false,
                                    scrollPadding: EdgeInsets.all(0),
                                    textAlign: TextAlign.left,
                                    textCapitalization:TextCapitalization.sentences,
                                    showCursor: true,
                                    autocorrect: false,
                                    cursorColor: Colors.black,
                                    autofocus: false,
                                    enableInteractiveSelection: true,
                                    readOnly: false,
                                    scrollController: ScrollController(),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 148.82,
                                top: 27,
                                child: Container(
                                  width: 241.56,
                                  height: 55.37,
                                  child: TextFormField(
                                    controller: _jobTitleController,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontFamily: 'Poly',
                                      fontWeight: FontWeight.w400,
                                    ),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Enter job title',
                                      hintStyle: TextStyle(
                                        color: Color.fromARGB(62, 66, 64, 64),
                                        fontSize: 15,
                                        fontFamily: 'Poly',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                    maxLines: 1,
                                    keyboardType: TextInputType.multiline,
                                    textInputAction: TextInputAction.newline,
                                    scrollPhysics: ClampingScrollPhysics(),
                                    textAlignVertical: TextAlignVertical.center,
                                    expands: false,
                                    scrollPadding: EdgeInsets.all(0),
                                    textAlign: TextAlign.left,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    showCursor: true,
                                    autocorrect: false,
                                    cursorColor: Colors.black,
                                    autofocus: false,
                                    enableInteractiveSelection: true,
                                    readOnly: false,
                                    scrollController: ScrollController(),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 153.09,
                                top: 235.34,
                                child: Container(
                                  width: 241.56,
                                  height: 55.37,
                                  child: TextFormField(
                                    controller: _locationController,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontFamily: 'Poly',
                                      fontWeight: FontWeight.w400,
                                    ),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Enter Location',
                                      hintStyle: TextStyle(
                                        color: Color.fromARGB(62, 66, 64, 64),
                                        fontSize: 15,
                                        fontFamily: 'Poly',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                    maxLines: 1,
                                    keyboardType: TextInputType.multiline,
                                    textInputAction: TextInputAction.newline,
                                    scrollPhysics: ClampingScrollPhysics(),
                                    textAlignVertical: TextAlignVertical.center,
                                    expands: false,
                                    scrollPadding: EdgeInsets.all(0),
                                    textAlign: TextAlign.left,
                                    textCapitalization:TextCapitalization.sentences,
                                    showCursor: true,
                                    autocorrect: false,
                                    cursorColor: Colors.black,
                                    autofocus: false,
                                    enableInteractiveSelection: true,
                                    readOnly: false,
                                    scrollController: ScrollController(),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 33.65,
                                top: 41,
                                child: SizedBox(
                                  width: 122.31,
                                  height: 36.86,
                                  child: Text(
                                    'Job title   :\n',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontFamily: 'Poly',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 24,
                                top: 174,
                                child: SizedBox(
                                  width: 135.96,
                                  height: 35.83,
                                  child: Text(
                                    'Requirements :',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontFamily: 'Poly',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 14,
                        top: 122,
                        child: Container(
                          width: 46,
                          height: 46,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/posstoffr.png'),
                              fit: BoxFit.fill,
                            ),
                            shape: OvalBorder(),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 14,
                        top: 521,
                        child: SizedBox(
                          width: 108,
                          height: 27,
                          child: Text(
                            'Salary  :',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'Poly',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    Positioned(
                      left: 92,
                      top: 655,
                      child: SizedBox(
                        width: 196,
                        height: 50,
                        child:_isLoading
                        ? Center(
                         child: CircularProgressIndicator(),
                        )
                         :ElevatedButton(
                          onPressed: _submitOffer,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 50, 217, 223),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Submit offer              ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontFamily: 'Lexend Deca',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
            Positioned(
            right: 16, // Adjust this as needed
            bottom: 60, // Adjust this as needed
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManageOffersPage()),
                );
              },
              child: Text(
                'See all your offers',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lexend Deca',
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 25, 14, 249), // Set the text color to blue
                  decoration: TextDecoration.underline, // Underline the text
                  decorationColor: Color.fromARGB(255, 25, 14, 249), // Underline color
                  decorationThickness: 2.0, // Thickness of the underline

                ),
              ),
            ),
          ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20), // Add space between the button and the fetched data
  
      ]),
      
    );
  }
}

