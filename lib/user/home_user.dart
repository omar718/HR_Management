import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:flutter_application_2/user/profile.dart';
import 'package:flutter_application_2/user/interviews.dart';
import 'package:flutter_application_2/homePage/home.dart'; // Import your homePage widget
import 'package:flutter_application_2/global/common/toast.dart'; // Import your custom toast function
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const HomeUser());
}

class HomeUser extends StatefulWidget {
  const HomeUser({super.key});

  @override
  State<HomeUser> createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        platform: TargetPlatform.android, 
      ),
      debugShowCheckedModeBanner: false,
      home: const UserHome(),
    );
  }
}

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
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
                left: -219,
                top: 114,
                child: Container(
                  width: 400,
                  height: 708,
                  decoration: const ShapeDecoration(
                    color: Color(0xC6D7E4E8),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: 6,
                top: 270,
                child: Container(
                  width: 110,
                  height: 28.50,
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
                left: 4,
                top: 533,
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
                            // Show a smaller AlertDialog with a blue background
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Color.fromARGB(225, 77, 182,
                                      239), // Set background color to blue
                                  content: Container(
                                    width: 100, // Set a fixed width
                                    height: 20, // Set a fixed height
                                    alignment: Alignment.center,
                                    child: Text(
                                      "You are not assigned to any tasks.",
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 9, 1, 1)),
                                      // Content text color
                                      textAlign: TextAlign
                                          .center, // Center text alignment
                                    ),
                                  ),
                                  actions: [
                                    Center(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          "OK",
                                          style: TextStyle(
                                              color: Color.fromARGB(255, 226, 5,
                                                  5)), // Button text color
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
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
                left: 200,
                top: -2,
                child: Container(
                  width: 52,
                  height: 50,
                  decoration: const ShapeDecoration(
                    color: Color(0xFFCAF0FC),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: 350,
                top: 770,
                child: Container(
                  width: 52,
                  height: 50,
                  decoration: const ShapeDecoration(
                    color: Color(0xFFCAF0FC),
                    shape: OvalBorder(),
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
                                builder: (context) => interview(),
                              ),
                            );
                          },
                          child: SizedBox(
                            width: 137,
                            child: Text(
                              'Interview',
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
