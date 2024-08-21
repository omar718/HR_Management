import 'package:flutter/material.dart';
import 'package:flutter_application_2/admin/Applications.dart';
import 'package:flutter_application_2/admin/Supervise_time.dart';
import 'package:flutter_application_2/admin/interviews.dart';
import 'package:flutter_application_2/admin/postoffer.dart';
import 'package:flutter_application_2/admin/profile.dart';
import 'package:flutter_application_2/admin/tasks.dart';
import 'package:flutter_application_2/HomePage/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_2/global/common/toast.dart'; // Import your custom toast function

void main() {
  runApp(const homeAdmin());
}

class homeAdmin extends StatelessWidget {
  const homeAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        platform: TargetPlatform.android, 
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeAdmin(),
    );
  }
}

class HomeAdmin extends StatelessWidget {
  const HomeAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: const Color.fromARGB(240, 255, 255,
              255), // Arrière-plan bleu pour l'ensemble de la liste
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 150,
                child: Container(
                  width: 150,
                  height: 40,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 39,
                        top: 0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => profile()),
                            );
                          },
                          child: Text(
                            'Profile',
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
                          width: 34,
                          height: 34,
                          decoration: const ShapeDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/update.png'),
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
                left: 0,
                top: 230,
                child: Container(
                  width: 150,
                  height: 40,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 39,
                        top: 0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PostOfferPage()),
                            );
                          },
                          child: Text(
                            'Offers',
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
                          width: 34,
                          height: 37,
                          decoration: const ShapeDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/posstoffr.png'),
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
                left: 0,
                top: 310,
                child: Container(
                  width: 250,
                  height: 42,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 47,
                        top: 8,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Application()),
                            );
                          },
                          child: SizedBox(
                            width: 150,
                            child: Text(
                              'Applications',
                              style: GoogleFonts.lexendDeca(
                                color: Color.fromARGB(255, 3, 3, 3),
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                height: 1.2, // Hauteur de ligne pour espacement
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 36,
                          height: 42,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/Application.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 390,
                child: Container(
                  width: 192,
                  height: 46,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 55,
                        top: 11,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => interviews()),
                            );
                          },
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
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 46,
                          height: 46,
                          decoration: const ShapeDecoration(
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
                left: 4,
                top: 470,
                child: Container(
                  width: 126.98,
                  height: 42,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 47,
                        top: 8,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => tasks()),
                            );
                          },
                          child: SizedBox(
                            width: 79.98,
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
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 36,
                          height: 42,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/task.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 4,
                top: 550,
                child: Container(
                  width: 250,
                  height: 70,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 47,
                        top: 0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Supervise_time()),
                            );
                          },
                          child: SizedBox(
                            width: 150,
                            child: Text(
                              'Supervise \n time',
                              style: GoogleFonts.lexendDeca(
                                color: Color.fromARGB(255, 3, 3, 3),
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                height: 1.2, // Hauteur de ligne pour espacement
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 36,
                          height: 42,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/supervis.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 280,
                top: 80,
                child: Container(
                  width: 51,
                  height: 53,
                  decoration: const ShapeDecoration(
                    color: Color.fromARGB(139, 145, 197, 240),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: -15,
                top: 70,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const ShapeDecoration(
                    color: Color.fromARGB(111, 126, 188, 238),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: -2,
                top: 750,
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: const ShapeDecoration(
                    color: Color.fromARGB(67, 56, 139, 207),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: 220,
                top: 700,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const ShapeDecoration(
                    color: Color.fromARGB(163, 121, 191, 234),
                    shape: OvalBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 192, 224,
            240), // Couleur bleu clair pour la barre d'applications
        iconTheme: const IconThemeData(
          color:
              Colors.black, // Couleur noire pour l'icône de la barre latérale
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
      body: ListView(
        children: const [
          MainLog(),
        ],
      ),
    );
  }
}

class MainLog extends StatelessWidget {
  const MainLog({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width,
      height: screenSize.height,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        shadows: const [
          BoxShadow(
            color: Color.fromARGB(225, 255, 255, 255),
            blurRadius: 25,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            left: 75,
            top: screenSize.height * 0.65, // Ajusté proportionnellement
            child: Container(
              width: 34,
              height: 34,
              decoration: const ShapeDecoration(
                color: Color(0x842F9BFF),
                shape: OvalBorder(),
              ),
            ),
          ),
          Positioned(
            left: screenSize.width * 0.6, // Ajusté proportionnellement
            top: screenSize.height * 0.78, // Ajusté proportionnellement
            child: Container(
              width: 52,
              height: 52,
              decoration: const ShapeDecoration(
                color: Color.fromARGB(119, 104, 188, 234),
                shape: OvalBorder(),
              ),
            ),
          ),
          Positioned(
            left: -35,
            top: screenSize.height * 0.88, // Ajusté proportionnellement
            child: Container(
              width: 71,
              height: 71,
              decoration: const ShapeDecoration(
                color: Color.fromARGB(67, 75, 136, 193),
                shape: OvalBorder(),
              ),
            ),
          ),
          Positioned(
            left: 20, // Ajusté pour être dans les limites de l'écran
            top: 300, // Ajusté proportionnellement
            child: SizedBox(
              width: screenSize.width - 40, // Pleine largeur avec des marges
              height: 100, // Hauteur ajustée pour correspondre au texte
              child: Text(
                'Welcome to\n  your workspace',
                style: GoogleFonts.itim(
                  color: Color(0xFF6F3DA1),
                  fontSize: 40,
                  fontWeight: FontWeight.w400,
                  height: 1.2, // Hauteur de ligne pour espacement
                ),
              ),
            ),
          ),
          Positioned(
            left: 27,
            top: 122,
            child: Container(
              width: 312,
              height: 173,
              decoration: ShapeDecoration(
                image: const DecorationImage(
                  image: AssetImage('images/logo.png'), // Image fictive
                  fit: BoxFit.fill,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
          Positioned(
            left: -24,
            top: 109,
            child: Container(
              width: 53,
              height: 53,
              decoration: const ShapeDecoration(
                color: Color.fromARGB(62, 88, 134, 252),
                shape: OvalBorder(),
              ),
            ),
          ),
          Positioned(
            left: screenSize.width - 135, // Ajusté pour s'adapter à l'écran
            top: 80,
            child: Container(
              width: 50,
              height: 50,
              decoration: const ShapeDecoration(
                color: Color.fromARGB(64, 202, 240, 252),
                shape: OvalBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}