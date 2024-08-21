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
      home: Scaffold(
        body: ListView(children: [
          tasks(),
        ]),
      ),
    );
  }
}

class tasks extends StatefulWidget {
  @override
  _tasksState createState() => _tasksState();
}

class _tasksState extends State<tasks> {
  final _titleController = TextEditingController();
  final _assignedToController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _projectController = TextEditingController();
  final _priorityController = TextEditingController();
  final _statusController = TextEditingController();

  DateTime? dueDate;
  DateTime? createdAt;
  DateTime? updatedAt;

  Future<void> _selectDateTime(BuildContext context, Function(DateTime) onSelected) async {
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
                            'Tasks',
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
                        left: -33,
                        top: 168,
                        child: Container(
                          width: 429,
                          height: 614,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 429,
                                  height: 613.52,
                                  decoration: ShapeDecoration(
                                    color: Color(0x84D9D9D9),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 89.62,
                                child: SizedBox(
                                  width: 175.41,
                                  height: 29.17,
                                  child: Text(
                                    'Title  :',
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
                                left: 9.02,
                                top: 225.77,
                                child: SizedBox(
                                  width: 178.25,
                                  height: 27.13,
                                  child: Text(
                                    'Assigned to :',
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
                                left: 164.38,
                                top: 145.85,
                               child: Container(
                                    width: 241.56,
                                    height: 55.37,
                                    child: TextFormField(
                                      controller: _titleController,
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
                                        hintText: '________',
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
                                left: 164.38,
                                top: 78.76,
                                child: Container(
                                    width: 241.56,
                                    height: 55.37,
                                    child: TextFormField(
                                      controller: _assignedToController,
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
                                        hintText: '_______',
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
                                left: 163.38,
                                top: 12.64,
                                child: Container(
                                    width: 241.56,
                                    height: 55.37,
                                    child: TextFormField(
                                      controller: _projectController,
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
                                        hintText: '_______',
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
                                left: 164.38,
                                top: 520,
                                child: Container(
                                  width: 243.15,
                                  height: 38.40,
                                  child: GestureDetector(
                                    onTap: () => _selectDateTime(context, (selectedDateTime) {
                                      setState(() {
                                        createdAt = selectedDateTime;
                                      });
                                    }),
                                    child: AbsorbPointer(
                                      child: TextField(
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
                                          hintText: createdAt == null
                                              ? 'Created at'
                                              : DateFormat('yyyy-MM-dd – HH:mm').format(createdAt!),
                                          hintStyle: TextStyle(
                                            color: Color.fromARGB(62, 66, 64, 64),
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
                                left: 165.39,
                                top: 570.60,
                                child: Container(
                                  width: 243.15,
                                  height: 38.40,
                                  child: GestureDetector(
                                    onTap: () => _selectDateTime(context, (selectedDateTime) {
                                      setState(() {
                                        updatedAt = selectedDateTime;
                                      });
                                    }),
                                    child: AbsorbPointer(
                                      child: TextField(
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
                                          hintText: updatedAt == null
                                              ? 'Updated at'
                                              : DateFormat('yyyy-MM-dd – HH:mm').format(updatedAt!),
                                          hintStyle: TextStyle(
                                            color: Color.fromARGB(62, 66, 64, 64),
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
                                left: 165.39,
                                top: 290,
                                child: Container(
                                width: 241.56,
                                    height: 55.37,
                                  child: GestureDetector(
                                    onTap: () => _selectDateTime(context, (selectedDateTime) {
                                      setState(() {
                                        dueDate = selectedDateTime;
                                      });
                                    }),
                                    child: AbsorbPointer(
                                      child: TextField(
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
                                          hintText: dueDate == null
                                              ? 'Due date'
                                              : DateFormat('yyyy-MM-dd – HH:mm').format(dueDate!),
                                          hintStyle: TextStyle(
                                            color: Color.fromARGB(62, 66, 64, 64),
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
                                left: 163.38,
                                top: 450.01,
                               child: Container(
                                    width: 241.56,
                                    height: 55.37,
                                    child: TextFormField(
                                      controller: _priorityController,
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
                                        hintText: '______',
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
                                left: 163.38,
                                top: 385.03,
                             child: Container(
                                    width: 241.56,
                                    height: 55.37,
                                    child: TextFormField(
                                      controller: _statusController,
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
                                        hintText: '______',
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
                                left: 164.38,
                                top: 213.91,
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
                                        hintText: '______',
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
                                left: 23.70,
                                top: 23.87,
                                child: SizedBox(
                                  width: 122.60,
                                  height: 35.84,
                                  child: Text(
                                    'Projrct :',
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
                                left: 14.03,
                                top: 160.71,
                                child: SizedBox(
                                  width: 160.37,
                                  height: 35,
                                  child: Text(
                                    'Description :',
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
                        top: 118,
                        child: Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/task.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 5,
                        top: 467,
                        child: SizedBox(
                          width: 125,
                          height: 34,
                          child: Text(
                            'Due date :',
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
                        left: 11,
                        top: 742,
                        child: SizedBox(
                          width: 125,
                          height: 34,
                          child: Text(
                            'Updated at :',
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
                        left: 7,
                        top: 690,
                        child: SizedBox(
                          width: 125,
                          height: 34,
                          child: Text(
                            'Created at  :',
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
                        left: 11,
                        top: 629,
                        child: SizedBox(
                          width: 125,
                          height: 34,
                          child: Text(
                            'Priority :',
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
                        left: 7,
                        top: 566,
                        child: SizedBox(
                          width: 125,
                          height: 34,
                          child: Text(
                            'Status :',
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
                        left: 101,
                        top: 797,
                        child: SizedBox(
                          width: 196,
                          height: 50,
                          child: ElevatedButton(
                                  onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 50, 217,
                                  223), // Green button for Renewal
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Submit task              ',
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
              MaterialPageRoute(builder: (context) => homeAdmin()),
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
                      image: AssetImage('images/profil.png'),
                      fit: BoxFit.fill,
                    ),
                    shape: OvalBorder(
                      side: BorderSide(
                          width: 1, color: Color.fromARGB(70, 47, 154, 255)),
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

                              
   
