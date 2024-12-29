import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:neuroTrack/data/commentData.dart';
import 'package:neuroTrack/theme/colors.dart';
import 'package:neuroTrack/widgets/loading/snacbar.dart';

class CommentDetailScreen extends StatefulWidget {
  final String userId;
  final String userName;

  const CommentDetailScreen(
      {super.key, required this.userId, this.userName = ''});

  @override
  _CommentDetailScreenState createState() => _CommentDetailScreenState();
}

class _CommentDetailScreenState extends State<CommentDetailScreen> {
  String userRole = '';
  bool _isLoading = true;
  final bool _isSubmitting = false;
  final storage = const FlutterSecureStorage();
  List<CommentData> _comments = [];

  @override
  void initState() {
    super.initState();
    _fetchRole();
    _fetchComments();
  }

  Future<void> _fetchRole() async {
    final storage = const FlutterSecureStorage();
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
          'https://stress-bee.onrender.com/api/participants/$participantId/comment');
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
                  children: [const Text("Supervisor: "), Text(comment.body)],
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
              backgroundColor: AppColor.blue,
              onPressed: _showAddCommentDialog,
              tooltip: 'Add Comment',
              child: const Icon(
                Icons.add,
                color: AppColor.white,
              ),
            )
          : null,
    );
  }

  void _showAddCommentDialog() {
    TextEditingController commentController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColor.blue.withOpacity(0.5),
          title: const Text(
            'Add Comment',
            style: TextStyle(color: AppColor.white),
          ),
          content: TextField(
            cursorColor: AppColor.white,
            style: TextStyle(color: AppColor.white),
            controller: commentController,
            decoration: const InputDecoration(
                hintText: "Enter your comment here", fillColor: AppColor.white),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: AppColor.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Submit',
                style: TextStyle(color: AppColor.white),
              ),
              onPressed: () {
                if (commentController.text.isNotEmpty) {
                  _submitComment(commentController.text).then((_) {
                    commentController.clear();
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
        'https://stress-bee.onrender.com/api/participants/$participantId/comment');
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
