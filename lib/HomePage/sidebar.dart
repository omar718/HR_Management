// lib/sidebar.dart
import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 350.0, // Adjust height as needed
            child: DrawerHeader(
              padding: EdgeInsets.zero,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                    radius: 50.0, // Adjust the radius as needed
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'User Name',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'user@example.com', // Replace with actual user email
                    style: TextStyle(
                      color: Colors.black54, // Subtle color for email
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: Icon(Icons.person, color: Colors.teal),
                  title: Text('Profile', style: TextStyle(color: Colors.black)),
                  onTap: () {
                    // Handle profile tap
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings, color: Colors.deepOrange),
                  title: Text('Settings', style: TextStyle(color: Colors.black)),
                  onTap: () {
                    // Handle settings tap
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.help, color: Colors.purple),
                  title: Text('Help', style: TextStyle(color: Colors.black)),
                  onTap: () {
                    // Handle help tap
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout, color: Colors.red),
                  title: Text('Logout', style: TextStyle(color: Colors.black)),
                  onTap: () {
                    // Handle logout tap
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
