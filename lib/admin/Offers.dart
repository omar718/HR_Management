import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_2/HomePage/home.dart';
import 'package:flutter_application_2/admin/postoffer.dart';
import 'package:flutter_application_2/global/common/toast.dart'; // Import your custom toast function

class ManageOffersPage extends StatefulWidget {
  @override
  _ManageOffersPageState createState() => _ManageOffersPageState();
}

class _ManageOffersPageState extends State<ManageOffersPage> {
  @override
  late String currentAdminId; // Variable to hold the current admin's ID "late" allows the variable to not be initialised
  void initState() {
    super.initState();
    _getCurrentAdminId();
  }
  Future<void> _getCurrentAdminId() async {
      // Get the current user's ID 
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        setState(() {
          currentAdminId = user.uid;
        });
      }
    }

  void _showDeleteJobDialog(String jobId) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure you want to delete this job offer?'),
            actions: <Widget>[
              TextButton(
                child: Text('Yes'),
                onPressed: () async {
              Navigator.of(context).pop(); // Close the dialog
              _deleteJob(jobId); // Perform deletion
            },
                 
              ),
              TextButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context)
                      .pop(); // Close the dialog without doing anything
                },
              ),
            ]
          );
        },
      );
  }
  Widget build(BuildContext context) {
    return Scaffold(
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
              MaterialPageRoute(builder: (context) => PostOfferPage()),
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
                onSelected: (String choice) async{
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
      body: currentAdminId == null
        ? Center(child: Text('Loading...'))
        : StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('jobs')
        .where('adminID', isEqualTo: currentAdminId)
                .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data?.docs.isEmpty == true) {
            return Center(child: Text("You haven't posted any job offer yet "));
          }

          final jobs = snapshot.data?.docs ?? [];

          return ListView.builder(
            itemCount: jobs.length,
            itemBuilder: (context, index) {
              final job = jobs[index];
              final jobTitle = job['title'] ?? 'No title'; // Provide default values
              final description = job['description'] ?? 'No description';
              final requirements = job['requirements'] ?? 'No requirements';
              final location = job['location'] ?? 'No location';
              final salary = job['salary'] ?? 'No salary';
              final status = job['status'] ?? 'closed'; // Default to 'closed'


              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Text(jobTitle),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Description: $description'),
                      Text('Requirements: $requirements'),
                      Text('Location: $location'),
                      Text('Salary: $salary TND'),
                      Text('Status: $status')
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          status == 'open' ? Icons.lock_open : Icons.lock,
                          color: status == 'open' ? Colors.blue : Colors.grey ,
                        ),
                        onPressed: () {
                          // Toggle status between 'open' and 'closed'
                          _toggleStatus(job.id, status);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _showDeleteJobDialog(job.id);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _toggleStatus(String jobId, String currentStatus) async {
    try {
      final newStatus = currentStatus == 'open' ? 'closed' : 'open';
      await FirebaseFirestore.instance.collection('jobs').doc(jobId).update({'status': newStatus});
      showToast (message: 'Status updated to $newStatus');
    } catch (error) {
      showToast (message: 'Failed to update job status: $error');
    }
  }

  void _deleteJob(String jobId) async {
    try {
      await FirebaseFirestore.instance.collection('jobs').doc(jobId).delete();
      showToast (message: 'Job offer deleted successfully');    
      } catch (error) {
      showToast (message: 'Failed to delete job offer');    
    }
  }
}
