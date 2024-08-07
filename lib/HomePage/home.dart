import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting the date
import 'sidebar.dart'; // Import the sidebar widget
import 'ChatRome.dart'; // Import the Chat Rome

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
            Scaffold.of(context).openDrawer();
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
                            Icon(Icons.share_outlined, color: Colors.blue),
                            SizedBox(width: 1.0),
                            Text('$shareCount Shares', style: TextStyle(color: Colors.blue)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {},
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
                  if (_showCommentField[index] == true) ...[
                    SizedBox(height: 16.0),
                    TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        hintText: 'Add a comment...',
                        prefixIcon: CircleAvatar(
                          backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                          radius: 10.0,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.send, color: Colors.cyan),
                          onPressed: () => _postComment(index),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[400]!),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyan),
                        ),
                      ),
                      cursorColor: Colors.cyan,
                    ),
                    SizedBox(height: 16.0),
                    ...comments.map((comment) => CommentWidget(
                      comment: comment,
                      commentIndex: comments.indexOf(comment),
                      onReply: (index) {
                        setState(() {
                          _commentReplies[comments.indexOf(comment)] = _commentReplies[comments.indexOf(comment)] ?? [];
                        });
                      },
                      onPostReply: _postReply,
                      replies: _commentReplies[comments.indexOf(comment)] ?? [],
                      onReplyIconPressed: () {
                        setState(() {
                          _showCommentField[index] = true;
                        });
                      },
                      reactions: _reactions,
                    )).toList(),
                  ],
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
  Map<String, dynamic>? reaction;

  Comment({
    required this.text,
    required this.picture,
    required this.name,
    required this.time,
    required this.replies,
    this.reaction,
  });
}

class CommentWidget extends StatefulWidget {
  final Comment comment;
  final int commentIndex;
  final Function(int) onReply;
  final Function(int) onPostReply;
  final List<Comment> replies;
  final VoidCallback onReplyIconPressed;
  final List<Map<String, dynamic>> reactions;

  const CommentWidget({
    required this.comment,
    required this.commentIndex,
    required this.onReply,
    required this.onPostReply,
    required this.replies,
    required this.onReplyIconPressed,
    required this.reactions,
  });

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  final _replyController = TextEditingController();
  bool _showReplyField = false;

  void _postReply() {
    if (_replyController.text.isNotEmpty) {
      widget.onPostReply(widget.commentIndex);
      setState(() {
        _showReplyField = false;
      });
    }
  }

  void _showReactionPicker() async {
    final reaction = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose a reaction'),
          content: Wrap(
            spacing: 10.0,
            children: widget.reactions.map((reaction) {
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
        widget.comment.reaction = reaction;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedReaction = widget.comment.reaction;
    final reactionIcon = selectedReaction?['icon'] ?? Icons.thumb_up_alt_outlined;
    final reactionColor = selectedReaction?['color'] ?? Colors.blue;
    final reactionName = selectedReaction?['name'] ?? 'React';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.comment.picture),
                radius: 16.0,
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.comment.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.comment.time,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.0),
                    Text(widget.comment.text),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: _showReactionPicker,
                          child: Row(
                            children: [
                              Icon(
                                reactionIcon,
                                color: reactionColor,
                              ),
                              SizedBox(width: 4.0),
                              Text(reactionName, style: TextStyle(color: reactionColor)),
                            ],
                          ),
                        ),
                        SizedBox(width: 4.0),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _showReplyField = !_showReplyField;
                              widget.onReply(widget.commentIndex);
                            });
                          },
                          child: Row(
                            children: [
                              Icon(Icons.reply_outlined, color: Colors.green),
                              SizedBox(width: 4.0),
                              Text('Reply', style: TextStyle(color: Colors.green)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (_showReplyField) ...[
                      TextField(
                        controller: _replyController,
                        decoration: InputDecoration(
                          hintText: 'Add a reply...',
                          prefixIcon: CircleAvatar(
                            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                            radius: 10.0,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.send, color: Colors.cyan),
                            onPressed: _postReply,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[400]!),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyan),
                          ),
                        ),
                        cursorColor: Colors.cyan,
                      ),
                      SizedBox(height: 16.0),
                    ],
                    ...widget.replies.map((reply) => CommentWidget(
                      comment: reply,
                      commentIndex: widget.commentIndex,
                      onReply: (index) {},
                      onPostReply: (index) {},
                      replies: [],
                      onReplyIconPressed: () {},
                      reactions: widget.reactions,
                    )).toList(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
