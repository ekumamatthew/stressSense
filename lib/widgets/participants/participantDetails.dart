// file: lib/screens/participant_detail_screen.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:stressSense/data/participants.dart';
import 'package:stressSense/screens/dashboardScreens/layout/dashboardPage.dart';
import 'package:stressSense/theme/colors.dart';
import 'package:stressSense/widgets/loading/snacbar.dart';

class ParticipantDetailScreen extends StatefulWidget {
  final ParticipantData participant;

  const ParticipantDetailScreen({super.key, required this.participant});

  @override
  _ParticipantDetailScreenState createState() =>
      _ParticipantDetailScreenState();
}

bool _isSubmitting = false;
final storage = const FlutterSecureStorage();

class _ParticipantDetailScreenState extends State<ParticipantDetailScreen> {
  bool _isFormVisible = false;
  final _formKey = GlobalKey<FormState>();
  // String? _INITIAL_STRESS = "0";
  String? _FINAL_STRESS = '';
  void _toggleFormVisibility() {
    setState(() {
      _isFormVisible = !_isFormVisible;
    });
  }

  void handleNasaChange(String value) {
    setState(() {
      _FINAL_STRESS = value;
    });
  }

  // void handleStaiChange(String value) {
  //   setState(() {
  //     _INITIAL_STRESS = value;
  //   });
  // }

  void _submitForm() async {
    String? userToken = await storage.read(key: 'userToken');
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var url = Uri.parse(
          'https://stress-bee.onrender.com/api/participants/${widget.participant.id}/episodes');
      try {
        var response = await http.post(
          url,
          body: {'INITIAL_STRESS': "0", 'FINAL_STRESS': "$_FINAL_STRESS"},
          headers: {'Authorization': 'Bearer $userToken'},
        );
        var responseData = json.decode(response.body);
        if (responseData['success']) {
          CustomSnackbar.show(context, "Suuccess: Episode Added");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Dashboard()),
          );
        } else {
          var responseData = json.decode(response.body);

          String errorMessage =
              responseData['error'] ?? 'Unknown error occurred';
          CustomSnackbar.show(context, "Error: $errorMessage");
        }
      } catch (e) {
        print('Error occurred: $e');
        CustomSnackbar.show(context, "Upload Failed : $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stress Level details for ${widget.participant.name}'),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: _toggleFormVisibility,
                  child: Text(
                    _isFormVisible ? 'Cancel' : 'Add Episode',
                    style: const TextStyle(color: AppColor.blue),
                  ),
                ),
                Visibility(
                  visible: _isFormVisible,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // TextFormField(
                        //   decoration: InputDecoration(
                        //       labelText: 'INITIAL STRESS Value'),
                        //   keyboardType: TextInputType.number,
                        //   onChanged: handleStaiChange,
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Please enter a valid INITIAL STRESS value';
                        //     }
                        //     return null;
                        //   },
                        // ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: ' STRESS Value'),
                          keyboardType: TextInputType.number,
                          onChanged: handleNasaChange,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid STRESS value';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: _submitForm,
                          child: const Text(
                            'Submit Episode',
                            style: TextStyle(color: AppColor.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final episode = widget.participant.episodes[index];
                var stressvalue = episode.FINAL_STRESS;
                return Column(
                  children: [
                    Card(
                      color: AppColor.blue.withOpacity(0.1),
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text('Episode ${index + 1}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //     'STRESS BEFORE TASK: ${episode.INITIAL_STRESS.toStringAsFixed(2)}'),
                            Text(
                                'STRESS VALUE: ${episode.FINAL_STRESS.toStringAsFixed(2)}'),
                            Text(stressvalue >= 80
                                ? 'High Stress'
                                : stressvalue >= 50
                                    ? 'Moderate Stress'
                                    : 'Low Stress' ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon:
                                  const Icon(Icons.edit, color: AppColor.blue),
                              onPressed: () => _showEditEpisodeDialog(
                                  widget.participant.id,
                                  index,
                                  widget.participant.episodes[index]),
                            ),
                            IconButton(
                                icon: const Icon(Icons.delete,
                                    color: AppColor.red),
                                onPressed: () => _showDeleteConfirmationDialog(
                                    widget.participant.id, index)),
                          ],
                        ),
                      ),
                    ),
                    if (index == widget.participant.episodes.length - 1 &&
                        widget.participant.episodes.isNotEmpty)
                      ElevatedButton(
                        onPressed: _showDeleteParticipantConfirmationDialog,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              AppColor.blue.withOpacity(0.5), // Button color
                        ),
                        child: const Text(
                          'Delete this participant',
                          style: TextStyle(color: AppColor.white),
                        ),
                      ),
                  ],
                );
              },
              childCount: widget.participant.episodes.length,
            ),
          ),
        ],
      ),
    );
  }

  void _showEditEpisodeDialog(
      String participantId, int episodeIndex, EpisodeData episodeData) {
    // Initialize controllers with existing values (no .toString() needed)
    // final INITIAL_STRESSController = TextEditingController(text: '');
    final FINAL_STRESSController = TextEditingController(text: '');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColor.blue.withOpacity(0.5),
          title: const Text(
            'Edit Episode',
            style: TextStyle(color: AppColor.white),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      // TextFormField(
                      //   keyboardType: TextInputType.number,
                      //   cursorColor: AppColor.white,
                      //   style: TextStyle(color: AppColor.white),
                      //   controller: INITIAL_STRESSController,
                      //   decoration: const InputDecoration(
                      //       labelText: 'Stress Level Before '),
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Please enter a valid Stress Level Before ';
                      //     }
                      //     return null;
                      //   },
                      // ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        cursorColor: AppColor.white,
                        style: TextStyle(color: AppColor.white),
                        controller: FINAL_STRESSController,
                        decoration: const InputDecoration(
                            labelText: 'Stress Level After'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid Stress Level After';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: AppColor.black),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text(
                'Update',
                style: TextStyle(color: AppColor.white),
              ),
              onPressed: () async {
                // Check validation before proceeding
                if (_formKey.currentState!.validate()) {
                  Navigator.of(context).pop();
                  await _updateEpisode(
                      participantId,
                      // INITIAL_STRESSController,
                      episodeIndex,
                      FINAL_STRESSController);
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateEpisode(
    String participantId,
    int episodeIndex,
    // TextEditingController INITIAL_STRESSController,
    TextEditingController FINAL_STRESSController,
  ) async {
    // Capture updated values from controllers
    // final initialValue = INITIAL_STRESSController.text;
    final finalValue = FINAL_STRESSController.text;
    var epiindex = episodeIndex + 1;
    final userToken = await storage.read(key: 'userToken');

    final data = json.encode({
      'FINAL_STRESS': finalValue,
      'INITIAL_STRESS': "0",
    });

    final url = Uri.parse(
        'https://stress-bee.onrender.com/api/participants/$participantId/episodes/$epiindex');

    try {
      print("Request Data: $data");
      final response = await http.patch(
        url,
        headers: {
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
        body: data,
      );

      final responseData = json.decode(response.body);
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200 && responseData['success']) {
        CustomSnackbar.show(context, "Success: Updated Episode");
        // Allow time for feedback before navigation
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Dashboard()),
          );
        });
      } else {
        final errorMessage = responseData['error'] ?? 'Unknown error occurred';
        CustomSnackbar.show(context, "Error: $errorMessage");
      }
    } catch (e) {
      print("Exception: $e");
      CustomSnackbar.show(context, "Error: Failed to Update Episode. $e");
    }
  }

  void _showDeleteConfirmationDialog(String participantId, int episodeIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColor.blue.withOpacity(0.5),
          title: const Text(
            'Confirm Delete',
            style: TextStyle(color: AppColor.white),
          ),
          content: const Text(
            'Are you sure you want to delete this episode?',
            style: TextStyle(color: AppColor.white),
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
                'Delete',
                style: TextStyle(color: AppColor.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteEpisode(participantId, episodeIndex);
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteEpisode(String participantId, episodeIndex) async {
    String? userToken = await storage.read(key: 'userToken');
    var epiindex = episodeIndex + 1;
    var url = Uri.parse(
        'https://stress-bee.onrender.com/api/participants/$participantId/episodes/$epiindex');
    try {
      var response = await http.delete(
        url,
        headers: {'Authorization': 'Bearer $userToken'},
      );
      var responseData = json.decode(response.body);
      if (responseData['success']) {
        CustomSnackbar.show(context, "Success: Deleted Episode");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Dashboard()),
        );
      } else {
        String errorMessage = responseData['error'] ?? 'Unknown error occurred';
        CustomSnackbar.show(context, "Error: $errorMessage");
      }
    } catch (e) {
      CustomSnackbar.show(context, "Error: Failed to Delete Episode. $e");
    }
  }

  void _handleDelete() async {
    String? userToken = await storage.read(key: 'userToken');
    var url = Uri.parse(
        'https://stress-bee.onrender.com/api/participants/${widget.participant.id}');

    try {
      var response = await http.delete(
        url,
        headers: {'Authorization': 'Bearer $userToken'},
      );
      var responseData = json.decode(response.body);
      if (responseData['success']) {
        CustomSnackbar.show(context, "Success: Deleted Participant");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Dashboard()),
        );
      } else {
        var responseData = json.decode(response.body);
        String errorMessage = responseData['error'] ?? 'Unknown error occurred';
        CustomSnackbar.show(context, "Error: $errorMessage");
      }
    } catch (e) {
      CustomSnackbar.show(context, "Error: Failed to Delete");
    }
  }

  void _showDeleteParticipantConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColor.blue.withOpacity(0.5),
          title: const Text('Confirm Delete'),
          content: const Text(
            'Are you sure you want to delete this participant? This action cannot be undone.',
            style: TextStyle(color: AppColor.white),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: AppColor.black),
              ),
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Dismiss the dialog without doing anything
              },
            ),
            TextButton(
              child: const Text(
                'Delete',
                style: TextStyle(color: AppColor.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _handleDelete();
              },
            ),
          ],
        );
      },
    );
  }
}
