import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore package
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:flutter_application_2/log-sign_in/login.dart';
import 'package:flutter_application_2/user/home_user.dart';
import 'package:flutter_application_2/user/profile.dart';
import 'package:flutter_application_2/admin/home_admin.dart';
import 'package:flutter_application_2/global/common/toast.dart'; // Import your custom toast function

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Firestore instance
  late Stream<List<Map<String, dynamic>>> _jobOffersStream; // Stream to listen to Firestore data
  final TextEditingController _searchController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _jobOffersStream = _firestore.collection('jobs').where('status', isEqualTo: 'open').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>?? {};
        final id = doc.id;
        return {
          'data': data,
          'id': id,
        };
      }).toList();
    });
  }
  // Method to update job offers based on search query
  void _updateJobOffers(String query) {
    setState(() {
      _jobOffersStream = _firestore.collection('jobs')
        .where('status', isEqualTo: 'open')
        .where('title', isGreaterThanOrEqualTo: query)
        .where('title', isLessThanOrEqualTo: query + '\uf8ff') // adding uf8ff displays the offers whatever the end of the string
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>?? {};
            final id = doc.id;
            return {
              'data': data,
              'id': id,
            };
          }).toList();
        });
    });
  }
void _onPhotoClicked(BuildContext context) async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    // If no user is not logged in, show a menu with only the Login option
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(10.0, kToolbarHeight +40.0, 0, 0),
      items: [
        PopupMenuItem(
          value: 'login',
          child: Row(
            children: [
              Icon(Icons.login, color: Colors.black),
              SizedBox(width: 8.0),
              Text('Login'),
            ],
          ),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
      if (value == 'login') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      }
    });
  } else {
    // Query the user's role from Firestore
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    final userRole = userDoc.data()?['role'];

    // Show the menu with Workspace and Logout options
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(10.0, kToolbarHeight +40.0, 0, 0),
      items: [
        PopupMenuItem(
          value: 'workspace',
          child: Row(
            children: [
              Icon(Icons.work, color: Colors.black),
              SizedBox(width: 8.0),
              Text('Workspace'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'logout',
          child: Row(
            children: [
              Icon(Icons.exit_to_app, color: Colors.black),
              SizedBox(width: 8.0),
              Text('Logout'),
            ],
          ),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
      if (value == 'workspace') {
        if (userRole == 'admin') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => homeAdmin(), // Replace with your admin home widget
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeUser(),
            ),
          );
        }
      } else if (value == 'logout') {
        FirebaseAuth.instance.signOut().then((_) {
          showToast(message: "Successfully logged out"); // Custom toast
        });
      }
    });
  }
}
void _showSubmissionDialog(BuildContext context) { //pop up to complete submission
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Color.fromARGB(223, 23, 71, 97),
        content: Container(
          width: 90,
          height: 80,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '''You should complete your submission before applying to a job offer. Go to your profile section in your workspace to complete it.''',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        actions: [
          Center(
            child: TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => profile()),
                );
              },
              label: Icon(
                Icons.arrow_right_alt, 
                color: Colors.black,
              ),
              icon: Text(
                "Go Now",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      );
    },
  );
}
Future<void> _applyNow( String jobID) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Handle case when user is not logged in
      showToast(message: "Please log in to apply.");
      return;
    }
    try {
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      final userFirstName = userDoc.data()?['firstName'];
      final userLastName = userDoc.data()?['lastName'];
      final userResume = userDoc.data()?['resume'];
      final userAppliedJobs = userDoc.data()?['appliedJobs'];
      String userRole = userDoc.data()?['role']; // not final because its value may change
      final jobDoc = await FirebaseFirestore.instance.collection('jobs').doc(jobID).get();
      String jobApplicants = jobDoc.data()?['applicants'];
      String jobTitle = jobDoc.data()?['title'];
      final adminID = jobDoc.data()?['adminID'];

      // Check if the important info exists
      if (userFirstName.isEmpty || userLastName.isEmpty || userResume.isEmpty) {
        _showSubmissionDialog(context); //popup call
        return;
      }

      if (userRole == 'guest' || userRole == 'applicant' || userRole == 'employee') {
        final applicationDoc = await FirebaseFirestore.instance //extracting the the collection document to check if it exists or not
          .collection('applications')
          .doc('${user.uid}_$jobTitle')
          .get();

        if (applicationDoc.exists) {             //checks if it exists
              showToast(message: "You have already applied to this job offer.");
              return;
            }

        String userName = '$userFirstName $userLastName'; // constructing the full name of the user
        // creates the fields of the document if it does not exist
        try {
          final applicationData = {
            'userID':user.uid,
            'adminID':adminID,
            'userName': userName,
            'jobTitle': jobTitle,
            'applicationDate': DateTime.now(),
            'status': 'pending',
            'interviews': '',
          };
        
          await _firestore.collection('applications').doc('${user.uid}_$jobTitle').set(applicationData);
          showToast(message: "Application submitted successfully.");
        } catch (e){
          showToast(message: "Error submitting application: $e");
        }
        // updates the appliedJobs and role fields of the users collection + applicants field for the job collection
        if(userAppliedJobs.isNotEmpty){ // checks if there are any previous job applications to not erase them
          jobTitle = "$userAppliedJobs, $jobTitle" ;
        }
        if(jobApplicants.isNotEmpty){
          userName ="$jobApplicants , $userName";
        }
        if (userRole == 'guest'){ // changes the guest role into applicant
          userRole = 'applicant';
        }

        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({'appliedJobs': jobTitle,'role': userRole});
        await FirebaseFirestore.instance.collection('jobs').doc(jobID).update({'applicants': userName});

      } else if (userRole=='admin'){
        showToast(message: "Admins can't apply to job offers.");
        return;
      } else {
        showToast(message: "You are not eligible to apply.");
      }
    } catch (e){
      showToast(message: "an error occured: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50]!,
      appBar: AppBar(
        automaticallyImplyLeading: false, // Prevents back arrow from appearing

        backgroundColor: Colors.grey[50]!,
        title: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            controller: _searchController,
            onChanged: _updateJobOffers, // Update job offers as user types
            decoration: InputDecoration(
              hintText: 'Search...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.search, color: Colors.grey),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: CircleAvatar(
              backgroundImage: NetworkImage('https://via.placeholder.com/50'),
            ),
            onPressed: () {
            _onPhotoClicked(context); // Call the method on photo tap
              
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _jobOffersStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No job offers available.'));
          }

          final jobOffers = snapshot.data!;

          return ListView.builder(
            itemCount: jobOffers.length,
            itemBuilder: (context, index) {
              final jobOffer = jobOffers[index];
              final jobData = jobOffer['data'] as Map<String, dynamic>;
              final jobId = jobOffer['id'] as String;

              return Card(
                margin: EdgeInsets.all(8.0),
                elevation: 4.0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        jobData['title'] ?? 'No Title',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        jobData['description'] ?? 'No Description',
                      ),
                      SizedBox(height: 8.0),
                      if (jobData['requirements'] != null && jobData['requirements'] is String && jobData['requirements']!.isNotEmpty) 
                        Text(
                          'Requirements:\n - ${(jobData['requirements'] as String).split(',').map((e) => e.trim()).join('\n - ')}', // Display requirements
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      SizedBox(height: 8.0),
                      Text(
                        'Location: ${jobData['location'] ?? 'Unknown'}',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Salary: ${jobData['salary'] != null ? '${jobData['salary']} TND' : 'Unknown'}',
                        style: TextStyle(color: Colors.green),
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {_applyNow(jobId);}, //apply job backend
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize: Size(double.infinity, 40.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.check_circle_outline, color: Colors.white),
                            SizedBox(width: 8.0),
                            Text('Apply Now', style: TextStyle(color: Colors.white)),
                          ],
                        ),
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
}
