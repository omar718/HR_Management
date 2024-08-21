import 'package:flutter/material.dart';
import 'home_admin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_2/global/common/toast.dart'; // Import your custom toast function
import 'package:flutter_application_2/HomePage/home.dart';
class FigmaToCodeApp extends StatelessWidget {
  const FigmaToCodeApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      home: Scaffold(
        body: ListView(children: [
          Application(),
        ]),
      ),
    );
  }
}

class Application extends StatelessWidget {
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
                top: 90,
                child: SizedBox(
                  width: 137,
                  child: Text(
                    'Applications',
                    style:  GoogleFonts.lexendDeca(
                  color: Color.fromARGB(255, 3, 3, 3),
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  height: 1.2, // Hauteur de ligne pour espacement
                ),
                  ),
                ),
              ),
              Positioned(
                left: -20,
                top: 186,
                child: Container(
                  width: 413,
                  height: 448,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 20,
                        top: 0,
                        child: Container(
                          width: 393,
                          height: 332,
                          decoration: ShapeDecoration(
                            color: Color.fromARGB(93, 217, 217, 217),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 1,
                        top: 115,
                        child: SizedBox(
                          width: 175,
                          height: 30,
                          child: Text(
                            ' Applicant name :',
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
                        left: 9,
                        top: 254,
                        child: SizedBox(
                          width: 177.83,
                          height: 27.91,
                          child: Text(
                            'Status:',
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
                        left: 160,
                        top: 179,
                        child: Container(
                          width: 242.58,
                          height: 36.86,
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
                                    hintText: 'Enter Application date ',
                                    hintStyle:  TextStyle(
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
                        left: 160,
                        top: 110,
                        child: Container(
                          width: 241.56,
                          height: 40.37,
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
                                    hintText: 'Enter Applicant name',
                                    hintStyle:  TextStyle(
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
                        left: 160,
                        top: 33,
                        child: Container(
                          width: 242.58,
                          height: 39.49,
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
                                    hintText: 'Enter job title',
                                    hintStyle:  TextStyle(
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
                        left: 160,
                        top: 249,
                        child: Container(
                          width: 242.58,
                          height: 36.86,
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
                                    hintText: 'Enter Status',
                                    hintStyle:  TextStyle(
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
                        left: 23.65,
                        top: 44.29,
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
                        left: 14,
                        top: 184,
                        child: SizedBox(
                          width: 160,
                          height: 36,
                          child: Text(
                            'Application date:',
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
                top:75,
                child: Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                     image: AssetImage('images/Application.png'),
                      fit: BoxFit.fill,
                    ),
                  
                  ),
                ),
              ),
             
                 Positioned(
                              left: 5,
                              top: 586,
                              child: SizedBox(
                                width: 150,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Logic for Renewal
                                    print('Accept  button clicked');
                                    // You can show a dialog or navigate to another screen here
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromARGB(255, 106, 131, 242), // Green button for Renewal
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    'Accept             ',
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
                              left: 0,
                              top: 502,
                              child: SizedBox(
                                width: 400,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Logic for Renewal
                                    print('Click To View Resume  button clicked');
                                    // You can show a dialog or navigate to another screen here

                                    
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromARGB(190, 160, 229, 238), // Green button for Renewal
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),

                                  ),
                                  child: Text(
                                   'Click To View Resume',
                                   textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color.fromARGB(203, 39, 36, 36),
                                      fontSize: 20,
                                     
                                      fontFamily: 'Lexend Deca',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
               Positioned(
                              left: 230,
                              top: 588,
                              child: SizedBox(
                                width: 150,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Logic for Renewal
                                    print('Refuse  button clicked');
                                    // You can show a dialog or navigate to another screen here

                                    
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromARGB(244, 243, 47, 25), // Green button for Renewal
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    
                                  ),
                                  child: Text(
                                    
                                   'Refuse',
                                   textAlign: TextAlign.center,
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
                                    builder: (context) =>homeAdmin()),
                              ); // Retourne à l'écran précédent
    },
  ),
        actions: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: PopupMenuButton<String>(
                icon: CircleAvatar(
                  backgroundImage: AssetImage('images/profil.png'), // Image de l'avatar
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