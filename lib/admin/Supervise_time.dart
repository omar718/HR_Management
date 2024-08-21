import 'package:flutter/material.dart';
import 'package:flutter_application_2/HomePage/home.dart';
import 'home_admin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_2/global/common/toast.dart'; // Import your custom toast function

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
          Supervise_time(),
        ]),
      ),
    );
  }
}

class Supervise_time extends StatelessWidget {
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
                    'Supervise time',
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
                left: 14,
                top:85,
                child: Container(
                  width: 46,
                  height: 46,
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
