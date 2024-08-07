import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  // Sample data for people in the chat room
  final List<String> people = [
    'Alice',
    'Bob',
    'Charlie',
    'David',
    'Eve',
    'Frank',
    'Grace',
    'Hank'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: people.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                child: Text(people[index][0]), // Display the first letter of the name
              ),
              title: Text(people[index]),
              onTap: () {
                // Navigate to chat with the selected person
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatDetailScreen(person: people[index]),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class ChatDetailScreen extends StatelessWidget {
  final String person;

  ChatDetailScreen({required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with $person'),
      ),
      body: Center(
        child: Text('Chat with $person'),
      ),
    );
  }
}
