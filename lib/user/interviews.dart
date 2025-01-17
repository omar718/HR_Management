import 'package:flutter/material.dart';
import 'package:flutter_application_2/HomePage/home.dart';
import 'home_user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_2/global/common/toast.dart'; // Import your custom toast function

// Generated by: https://www.figma.com/community/plugin/842128343887142055/
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      home: Scaffold(
        body: ListView(children: [
          interview(),
        ]),
      ),
    );
  }
}

class interview extends StatefulWidget {
  @override
  State<interview> createState() => _interviewState();
}

class _interviewState extends State<interview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 396,
                height: 800,
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
                      left: 21,
                      top: 119,
                      child: Container(
                        width: 192,
                        height: 46,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 55,
                              top: 11,
                              child: SizedBox(
                                width: 137,
                                child: Text(
                                  'interview',
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
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 46,
                                height: 46,
                                decoration: ShapeDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('images/interviw.png'),
                                    fit: BoxFit.fill,
                                  ),
                                  shape: OvalBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    Positioned(
                      left: -26,
                      top: 206,
                      child: Container(
                        width: 416,
                        height: 341,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 28,
                              top: 0,
                              child: Container(
                                width: 388,
                                height: 266,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFD9D9D9),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 190,
                              top: 293,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Logic for Refuse
                                  print('Refuse button clicked');
                                  // You can show a dialog or navigate to another screen here
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.red, // Red button for Refuse
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'Refuse',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: 'Poly',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 67.05,
                              top: 293,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Logic for Accept
                                  print('Accept button clicked');
                                  // You can show a dialog or navigate to another screen here
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.blue, // Blue button for Accept
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'Accept',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: 'Poly',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 303,
                              top: 296.5,
                              child: SizedBox(
                                width: 107,
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Logic for Renewal
                                    print('Renewal button clicked');
                                    // You can show a dialog or navigate to another screen here
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors
                                        .green, // Green button for Renewal
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    'Renewal',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: 'Poly',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 41.39,
                              top: 98.27,
                              child: SizedBox(
                                width: 117,
                                height: 23.85,
                                child: Text(
                                  'Recruiter  :',
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
                              top: 211,
                              child: SizedBox(
                                width: 174.47,
                                height: 31.80,
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
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 11,
                      top: 241,
                      child: SizedBox(
                        width: 120,
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
                      left: -3,
                      top: 366,
                      child: SizedBox(
                        width: 113,
                        height: 20,
                        child: Text(
                          'Time  :    ',
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
                            left: 124,
                            top: 238,
                            child: Container(
                              width: 238,
                               height: 42,
                              child: TextFormField(
                                enabled: false, // Rend le champ en lecture seule
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
                                  hintText: '',
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

                        Positioned(
                        left: 125,
                        top: 296,
                        child: Container(
                          width: 238,
                          height: 42,
                          child: TextFormField(
                            enabled: false, // Rend le champ en lecture seule
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
                              hintText: '',
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

                                        Positioned(
                      left: 124,
                      top: 407,
                      child: Container(
                       width: 238,
                       height: 42,
                        child: TextFormField(
                          enabled: false, // Rend le champ en lecture seule
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
                            hintText: '',
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

                                    Positioned(
                    left: 124,
                    top: 355,
                    child: Container(
                      width: 238,
                      height: 42,
                      child: TextFormField(
                        enabled: false, // Rend le champ en lecture seule
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
                          hintText: '',
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

                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
       appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 192, 224, 240), // Couleur bleu clair pour la barre d'applications
        iconTheme: const IconThemeData(
          color: Colors.black, // Couleur noire pour l'icône de la barre latérale
        ),
        leading: IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.black), // Icône de flèche de retour noire
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>HomeUser()),
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
                    image: 
                        AssetImage('images/profil.png') ,
                        
                    fit: BoxFit.fill,
                  ),
                  shape: OvalBorder(
                    side: BorderSide(width: 1, color: Color.fromARGB(70, 47, 154, 255)),
                  ),
                ),
              ),
                color: const Color.fromARGB(189, 106, 193, 227), // Couleur bleue pour le fond du menu contextuel
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
                          Icon(Icons.home, color: Colors.black, size: 24), // Icône noire pour Accueil
                          const SizedBox(width: 8),
                          const Text(
                            'Home',
                            style: TextStyle(color: Colors.black, fontSize: 16), // Taille du texte ajustée
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'Logout',
                      child: Row(
                        children: [
                          Icon(Icons.exit_to_app, color: Colors.black, size: 24), // Icône noire pour Déconnexion
                          const SizedBox(width: 8),
                          const Text(
                            'Logout',
                            style: TextStyle(color: Color.fromARGB(255, 132, 11, 11), fontSize: 16), // Taille du texte ajustée
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
