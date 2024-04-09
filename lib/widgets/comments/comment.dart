import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:stressSense_lab/data/commentData.dart';
import 'package:stressSense_lab/widgets/loading/snacbar.dart';

class CommentDetailScreen extends StatefulWidget {
  final String userId;
  final String userName;

  CommentDetailScreen({Key? key, required this.userId, this.userName = ''})
      : super(key: key);

  @override
  _CommentDetailScreenState createState() => _CommentDetailScreenState();
}

class _CommentDetailScreenState extends State<CommentDetailScreen> {
  String userRole = '';
  bool _isLoading = true;
  bool _isSubmitting = false;
  final storage = FlutterSecureStorage();
  List<CommentData> _comments = [];

  @override
  void initState() {
    super.initState();
    _fetchRole();
    _fetchComments();
  }

  Future<void> _fetchRole() async {
    final storage = FlutterSecureStorage();
    String? role = await storage.read(key: 'role');
    setState(() {
      userRole = role ?? '';
    });
  }

  Future<void> _fetchComments() async {
    String? userToken = await storage.read(key: 'userToken');
    String? participantId = widget.userId.toString();
    try {
      var url = Uri.parse(
          'https://stress-be.onrender.com/api/participants/$participantId/comment');
      var response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $userToken'},
      );

      final data = jsonDecode(response.body);
      print('comments: $data');
      if (data['success']) {
        setState(() {
          _isLoading = false;
          _comments = (data['data'] as List)
              .map((c) => CommentData.fromJson(c))
              .toList()
              .reversed
              .toList();
        });
      } else {
        print('Failed to load comments');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments for ${widget.userName}'),
      ),
      body: ListView.builder(
        itemCount: _comments.length,
        itemBuilder: (context, index) {
          final comment = _comments[index];

          final formattedTimestamp =
              DateFormat('yyyy-MM-dd – kk:mm').format(comment.timestamp);

          return ListTile(
            title: Text(comment.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [Text("Supervisor: "), Text(comment.body)],
                ),
                const SizedBox(height: 4),
                Text(
                  formattedTimestamp,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: userRole == 'supervisor'
          ? FloatingActionButton(
              onPressed: _showAddCommentDialog,
              child: Icon(Icons.add),
              tooltip: 'Add Comment',
            )
          : null,
    );
  }

  void _showAddCommentDialog() {
    TextEditingController _commentController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Comment'),
          content: TextField(
            controller: _commentController,
            decoration:
                const InputDecoration(hintText: "Enter your comment here"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Submit'),
              onPressed: () {
                if (_commentController.text.isNotEmpty) {
                  _submitComment(_commentController.text).then((_) {
                    _commentController.clear();
                    Navigator.of(context).pop();
                  }).catchError((error) {
                    print('Error submitting comment: $error');
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _submitComment(String comment) async {
    String? userToken = await storage.read(key: 'userToken');
    String? participantId = widget.userId.toString();
    print(participantId);
    print('dollar: $comment');
    var url = Uri.parse(
        'https://stress-be.onrender.com/api/participants/$participantId/comment');
    var data = {'comment': comment};
    try {
      var response = await http.post(
        url,
        body: data,
        headers: {'Authorization': 'Bearer $userToken'},
      );

      var responseData = json.decode(response.body);
      if (responseData['success']) {
        CustomSnackbar.show(context, "Success: Comment Added");
      } else {
        String errorMessage =
            responseData['error']['message'] ?? 'Unknown error occurred';
        print(errorMessage);
        CustomSnackbar.show(context, "Error: $errorMessage");
      }
    } catch (e) {
      print(e);
      CustomSnackbar.show(context, "Upload Failed : $e");
    }
  }
}
