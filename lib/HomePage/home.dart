import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:intl/intl.dart'; // Add this line
import 'package:flutter_application_2/log-sign_in/login.dart';
import 'package:flutter_application_2/global/common/toast.dart'; // Import your custom toast function
import 'sidebar.dart'; // Import the sidebar widget
import 'ChatRome.dart'; // Import the Chat Room

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _commentController = TextEditingController();
  final List<String> _jobOffers = [
    'Software Engineer',
    'Product Manager',
    'Data Scientist',
    'UX/UI Designer',
    'Marketing Specialist',
    'HR Coordinator',
    'Backend Developer',
    'Front-End Developer',
  ];

  final List<Map<String, dynamic>> _reactions = const [
    {'icon': Icons.thumb_up_alt_outlined, 'color': Colors.blue, 'name': 'Like'},
    {'icon': Icons.star_border, 'color': Colors.blueGrey, 'name': 'Celebrate'},
    {'icon': Icons.lightbulb_outline, 'color': Colors.yellow, 'name': 'Support'},
    {'icon': Icons.favorite_border, 'color': Colors.red, 'name': 'Love'},
    {'icon': Icons.highlight_off, 'color': Colors.grey, 'name': 'Dislike'},
  ];

  final Map<int, Map<String, dynamic>> _selectedReactions = {};
  final Map<int, bool> _showCommentField = {};
  final Map<int, int> _reactionCounts = {};
  final Map<int, int> _commentCounts = {};
  final Map<int, int> _shareCounts = {};
  final Map<int, List<Comment>> _comments = {};
  final Map<int, List<Comment>> _commentReplies = {};

  void _postComment(int index) {
    if (_commentController.text.isNotEmpty) {
      setState(() {
        final now = DateTime.now();
        final formatter = DateFormat('hh:mm a');
        final time = formatter.format(now);

        if (_comments[index] == null) {
          _comments[index] = [];
        }

        _comments[index]!.add(
          Comment(
            text: _commentController.text,
            picture: 'https://via.placeholder.com/50',
            name: 'User Name',
            time: time,
            replies: [],
            reaction: _selectedReactions[index],
          ),
        );
        _commentController.clear();
        _commentCounts[index] = (_commentCounts[index] ?? 0) + 1;
      });
    }
  }

  void _showReactionPicker(int index) async {
    final reaction = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose a reaction'),
          content: Wrap(
            spacing: 10.0,
            children: _reactions.map((reaction) {
              return GestureDetector(
                onTap: () {
                  Navigator.pop(context, reaction);
                },
                child: Column(
                  children: [
                    Icon(
                      reaction['icon'],
                      size: 24.0,
                      color: reaction['color'],
                    ),
                    SizedBox(height: 4.0),
                    Text(reaction['name']),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );

    if (reaction != null) {
      setState(() {
        _selectedReactions[index] = reaction;
        _reactionCounts[index] = (_reactionCounts[index] ?? 0) + 1;
      });
    }
  }

  void _toggleCommentField(int index) {
    setState(() {
      _showCommentField[index] = !(_showCommentField[index] ?? false);
    });
  }

  void _postReply(int commentIndex) {
    if (_commentController.text.isNotEmpty) {
      setState(() {
        final now = DateTime.now();
        final formatter = DateFormat('hh:mm a');
        final time = formatter.format(now);

        if (_commentReplies[commentIndex] == null) {
          _commentReplies[commentIndex] = [];
        }

        _commentReplies[commentIndex]!.add(
          Comment(
            text: _commentController.text,
            picture: 'https://via.placeholder.com/50',
            name: 'User Name',
            time: time,
            replies: [],
            reaction: _selectedReactions[commentIndex],
          ),
        );
        _commentController.clear();
      });
    }
  }

  void _onPhotoClicked(BuildContext context) {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    // If no user is logged in, show a menu with only the Login option
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(0, kToolbarHeight, 0, 0),
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
    // If the user is logged in, show the menu with Workspace and Logout options
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(0, kToolbarHeight, 0, 0),
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
      if (value == 'logout') {
        FirebaseAuth.instance.signOut().then((_) {
          showToast(message: "Successfully logged out"); // Custom toast
        });
      }
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50]!,
      appBar: AppBar(
        backgroundColor: Colors.grey[50]!,
        leading: IconButton(
          icon: CircleAvatar(
            backgroundImage: NetworkImage('https://via.placeholder.com/50'),
          ),
          onPressed: () {
            _onPhotoClicked(context); // Call the method on photo tap
          },
        ),
        title: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
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
            icon: Icon(Icons.message_outlined, color: Colors.grey),
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChatRoom(),
                ),
              );
            },
          ),
        ],
      ),
      drawer: Sidebar(), // Add the sidebar (drawer) here
      body: ListView.builder(
        itemCount: _jobOffers.length,
        itemBuilder: (context, index) {
          if (_showCommentField[index] == null) {
            _showCommentField[index] = false;
          }

          final selectedReaction = _selectedReactions[index];
          final reactionIcon = selectedReaction?['icon'] ?? Icons.thumb_up_alt_outlined;
          final reactionColor = selectedReaction?['color'] ?? Colors.blue;
          final reactionName = selectedReaction?['name'] ?? 'React';
          final reactionCount = _reactionCounts[index] ?? 0;
          final commentCount = _commentCounts[index] ?? 0;
          final shareCount = _shareCounts[index] ?? 0;
          final comments = _comments[index] ?? [];

          return Card(
            margin: EdgeInsets.all(8.0),
            elevation: 4.0,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                        radius: 20.0,
                      ),
                      SizedBox(width: 8.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Admin Name',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Just now',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    _jobOffers[index],
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Job description goes here. This is a brief description of the job offer.',
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => _showReactionPicker(index),
                        child: Row(
                          children: [
                            Icon(
                              reactionIcon,
                              color: reactionColor,
                            ),
                            SizedBox(width: 4.0),
                            Text('$reactionName ($reactionCount)', style: TextStyle(color: reactionColor)),
                          ],
                        ),
                      ),
                      SizedBox(width: 8.0),
                      TextButton(
                        onPressed: () {
                          _toggleCommentField(index);
                        },
                        child: Row(
                          children: [
                            Icon(Icons.comment_outlined, color: Colors.green),
                            SizedBox(width: 4.0),
                            Text('$commentCount Comments', style: TextStyle(color: Colors.green)),
                          ],
                        ),
                      ),
                      SizedBox(width: 1.0),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _shareCounts[index] = (_shareCounts[index] ?? 0) + 1;
                          });
                        },
                        child: Row(
                          children: [
                            Icon(Icons.share_outlined, color: Colors.blueGrey),
                            SizedBox(width: 4.0),
                            Text('$shareCount Shares', style: TextStyle(color: Colors.blueGrey)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (_showCommentField[index]!)
                    Column(
                      children: [
                        TextField(
                          controller: _commentController,
                          decoration: InputDecoration(
                            hintText: 'Write a comment...',
                            suffixIcon: IconButton(
                              icon: Icon(Icons.send, color: Colors.blue),
                              onPressed: () => _postComment(index),
                            ),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        for (var i = 0; i < comments.length; i++)
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(comments[i].picture),
                            ),
                            title: Text(comments[i].name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(comments[i].text),
                                Text(comments[i].time, style: TextStyle(fontSize: 12.0, color: Colors.grey)),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.reply, color: Colors.blue),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      padding: EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text('Reply to Comment', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                                          TextField(
                                            controller: _commentController,
                                            decoration: InputDecoration(
                                              hintText: 'Write a reply...',
                                              suffixIcon: IconButton(
                                                icon: Icon(Icons.send, color: Colors.blue),
                                                onPressed: () {
                                                  _postReply(i);
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Comment {
  final String text;
  final String picture;
  final String name;
  final String time;
  final List<Comment> replies;
  final Map<String, dynamic>? reaction;

  Comment({
    required this.text,
    required this.picture,
    required this.name,
    required this.time,
    required this.replies,
    this.reaction,
  });
}

