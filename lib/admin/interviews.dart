import 'package:flutter/material.dart';
import 'package:flutter_application_2/HomePage/home.dart';
import 'home_admin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_2/global/common/toast.dart'; // Import your custom toast function

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView(children: [
          interviews(),
        ]),
      ),
    );
  }
}

class interviews extends StatefulWidget {
  @override
  _InterviewsState createState() => _InterviewsState();
}

class _InterviewsState extends State<interviews> {
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _applicantController = TextEditingController();
  final TextEditingController _applicationDateController =TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  DateTime? selectedTime;

  Future<void> _selectDateTime(
      BuildContext context, Function(DateTime) onSelected) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (selectedDate != null) {
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (selectedTime != null) {
        final DateTime finalDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );
        onSelected(finalDateTime);
      }
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
                    width: 396,
                    height: 852,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Colors.white,
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
                              'Interviews',
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
                                  top: 109.56,
                                  child: SizedBox(
                                    width: 119.25,
                                    height: 20.93,
                                    child: Text(
                                      'Applicant :  ',
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
                                  top: 245.21,
                                  child: SizedBox(
                                    width: 177.83,
                                    height: 27.91,
                                    child: Text(
                                      'Time  :',
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
                                  left: 157,
                                  top: 170.64,
                                  child: Container(
                                    width: 241.56,
                                    height: 55.37,
                                    child: TextFormField(
                                      controller: _applicationDateController,
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
                                        hintText: 'Enter Application date',
                                        hintStyle: TextStyle(
                                          color: Color.fromARGB(62, 66, 64, 64),
                                          fontSize: 15,
                                          fontFamily: 'Poly',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please fill this field';
                                        }
                                        return null;
                                      },
                                      maxLines: 1,
                                      keyboardType: TextInputType.multiline,
                                      textInputAction: TextInputAction.newline,
                                      scrollPhysics: ClampingScrollPhysics(),
                                      textAlignVertical: TextAlignVertical.center,
                                      expands: false,
                                      scrollPadding: EdgeInsets.all(0),
                                      textAlign: TextAlign.left,
                                      textCapitalization: TextCapitalization.sentences,
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
                                      controller: _applicantController,
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
                                        hintText: 'Enter Applicant',
                                        hintStyle: TextStyle(
                                          color: Color.fromARGB(62, 66, 64, 64),
                                          fontSize: 15,
                                          fontFamily: 'Poly',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please fill this field';
                                        }
                                        return null;
                                      },
                                      maxLines: 1,
                                      keyboardType: TextInputType.multiline,
                                      textInputAction: TextInputAction.newline,
                                      scrollPhysics: ClampingScrollPhysics(),
                                      textAlignVertical: TextAlignVertical.center,
                                      expands: false,
                                      scrollPadding: EdgeInsets.all(0),
                                      textAlign: TextAlign.left,
                                      textCapitalization: TextCapitalization.sentences,
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
                                        hintText: 'Enter location',
                                        hintStyle: TextStyle(
                                          color: Color.fromARGB(62, 66, 64, 64),
                                          fontSize: 15,
                                          fontFamily: 'Poly',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please fill this field';
                                        }
                                        return null;
                                      },
                                      maxLines: 1,
                                      keyboardType: TextInputType.multiline,
                                      textInputAction: TextInputAction.newline,
                                      scrollPhysics: ClampingScrollPhysics(),
                                      textAlignVertical: TextAlignVertical.center,
                                      expands: false,
                                      scrollPadding: EdgeInsets.all(0),
                                      textAlign: TextAlign.left,
                                      textCapitalization: TextCapitalization.sentences,
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
                                  top: 27.66,
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
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please fill this field';
                                      }
                                      return null;
                                    },
                                    maxLines: 1,
                                    keyboardType: TextInputType.multiline,
                                    textInputAction: TextInputAction.newline,
                                    scrollPhysics: ClampingScrollPhysics(),
                                    textAlignVertical: TextAlignVertical.center,
                                    expands: false,
                                    scrollPadding: EdgeInsets.all(0),
                                    textAlign: TextAlign.left,
                                    textCapitalization: TextCapitalization.sentences,
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
                                    child: GestureDetector(
                                      onTap: () => _selectDateTime(context,
                                          (selectedDateTime) {
                                        setState(() {
                                          selectedTime = selectedDateTime;
                                        });
                                      }),
                                      child: AbsorbPointer(
                                        child: TextField(
                                          style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
                                            fontSize: 17,
                                            fontFamily: 'Poly',
                                            fontWeight: FontWeight.w400,
                                          ),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            hintText: selectedTime == null
                                                ? 'Date&Time'
                                                : DateFormat(
                                                        'yyyy-MM-dd – HH:mm')
                                                    .format(selectedTime!),
                                            hintStyle: TextStyle(
                                              color: Color.fromARGB(
                                                  141, 85, 76, 76),
                                              fontSize: 15,
                                              fontFamily: 'Poly',
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 33.65,
                                  top: 40.29,
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
                                  top: 170.54,
                                  child: SizedBox(
                                    width: 135.96,
                                    height: 35.83,
                                    child: Text(
                                      'Application \n date :',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
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
                            width: 50,
                            height: 50,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: AssetImage('images/interviw.png'),
                                fit: BoxFit.fill,
                              ),
                              shape: OvalBorder(),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 14,
                          top: 515,
                          child: SizedBox(
                            width: 108,
                            height: 27,
                            child: Text(
                              'Location :',
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
                            child: ElevatedButton(
                              onPressed: (){},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 50, 217,
                                    223), // Green button for Renewal
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Submit interview              ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontFamily: 'Lexend Deca',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 192, 224, 240),
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
              MaterialPageRoute(builder: (context) => homeAdmin()),
            ); // Retourne à l'écran précédent
          },
        ),
        actions: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0), // Espacement du bas
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/profil.png'),
                        fit: BoxFit.fill,
                      ),
                      shape: OvalBorder(
                        side: BorderSide(
                            width: 1, color: Color.fromARGB(70, 47, 154, 255)),
                      ),
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: Icon(Icons.arrow_drop_down,
                        color: Colors
                            .transparent), // Icône transparente pour ouvrir le menu
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
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'Logout',
                          child: Row(
                            children: [
                              Icon(Icons.exit_to_app,
                                  color: Colors.black, size: 24),
                              const SizedBox(width: 8),
                              const Text(
                                'Logout',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 132, 11, 11),
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ];
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10), // Espacement entre les icônes
        ],
      ),
    );
  }
}
