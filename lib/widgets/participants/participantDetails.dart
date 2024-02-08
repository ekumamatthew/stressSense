// file: lib/screens/participant_detail_screen.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_fizi_app/data/participants.dart';
import 'package:http/http.dart' as http;
import 'package:my_fizi_app/screens/dashboardScreens/layout/dashboardPage.dart';
import 'package:my_fizi_app/widgets/loading/loading.dart';
import 'package:my_fizi_app/widgets/loading/snacbar.dart';

class ParticipantDetailScreen extends StatefulWidget {
  final ParticipantData participant;

  const ParticipantDetailScreen({Key? key, required this.participant})
      : super(key: key);

  @override
  _ParticipantDetailScreenState createState() =>
      _ParticipantDetailScreenState();
}

bool _isSubmitting = false;
final storage = FlutterSecureStorage();

class _ParticipantDetailScreenState extends State<ParticipantDetailScreen> {
  bool _isFormVisible = false;
  final _formKey = GlobalKey<FormState>();
  String? _stai = '';
  String? _nasa = '';
  void _toggleFormVisibility() {
    setState(() {
      _isFormVisible = !_isFormVisible;
    });
  }

  void handleNasaChange(String value) {
    setState(() {
      _nasa = value;
    });
  }

  // void handleStaiChange(String value) {
  //   setState(() {
  //     _stai = value;
  //   });
  // }

  void _submitForm() async {
    String? userToken = await storage.read(key: 'userToken');
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var url = Uri.parse(
          'https://stresslysis.onrender.com/api/participants/${widget.participant.id}/episodes');
      try {
        var response = await http.post(
          url,
          body: {'NASA': "$_nasa", 'STAI': "1"},
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
        title: Text('Episode details for ${widget.participant.name}'),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: _toggleFormVisibility,
                  child: Text(_isFormVisible ? 'Cancel' : 'Add Episode'),
                ),
                Visibility(
                  visible: _isFormVisible,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // TextFormField(
                        //   decoration: InputDecoration(labelText: 'STAI Value'),
                        //   keyboardType: TextInputType.text,
                        //   onChanged: handleStaiChange,
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Please enter a valid STAI value';
                        //     }
                        //     return null;
                        //   },
                        // ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'NASA Value'),
                          keyboardType: TextInputType.text,
                          onChanged: handleNasaChange,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid NASA value';
                            }
                            return null;
                          },
                        ),
                        ElevatedButton(
                          onPressed: _submitForm,
                          child: const Text('Submit Episode'),
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
                var nasavalue = episode.nasa;
                return Column(
                  children: [
                    Card(
                      margin: EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text('Episode ${index + 1}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('NASA: ${episode.nasa.toStringAsFixed(2)}'),
                            Text(
                              nasavalue >= 80
                                  ? 'High Stress'
                                  : nasavalue >= 50
                                      ? 'Elevated Stress'
                                      : nasavalue >= 30
                                          ? 'Mildly Elevated Stress'
                                          : nasavalue >= 10
                                              ? 'Moderate Stress'
                                              : 'Minimal Stress',
                              // Additional styling can be applied here
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _showEditEpisodeDialog(
                                  widget.participant.id,
                                  index,
                                  widget.participant.episodes[index]),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                _showDeleteConfirmationDialog(
                                    widget.participant.id, index);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (index == widget.participant.episodes.length - 1 &&
                        widget.participant.episodes.isNotEmpty)
                      ElevatedButton(
                        onPressed: _showDeleteParticipantConfirmationDialog,
                        child: const Text('Delete this participant'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey, // Button color
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
    TextEditingController staiController =
        TextEditingController(text: episodeData.stai.toString());
    TextEditingController nasaController =
        TextEditingController(text: episodeData.nasa.toString());
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Episode'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      // TextFormField(
                      //   controller: staiController,
                      //   decoration: InputDecoration(labelText: 'STAI Value'),
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Please enter a valid STAI value';
                      //     }
                      //     return null;
                      //   },
                      // ),
                      TextFormField(
                        controller: nasaController,
                        decoration: InputDecoration(labelText: 'NASA Value'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid NASA value';
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
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Update'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  Navigator.of(context).pop();
                  await _updateEpisode(participantId, episodeIndex,
                      staiController, nasaController);
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
      TextEditingController staiController,
      TextEditingController nasaController) async {
    var epiindex = episodeIndex + 1;
    // var staiValue = staiController.text;
    var nasaValue = nasaController.text;
    String? userToken = await storage.read(key: 'userToken');
    var data = {'NASA': nasaValue, 'STAI': "1"};
    var url = Uri.parse(
        'https://stresslysis.onrender.com/api/participants/$participantId/episodes/$epiindex.');
    try {
      var response = await http.patch(url,
          headers: {'Authorization': 'Bearer $userToken'}, body: data);
      var responseData = json.decode(response.body);
      if (responseData['success']) {
        CustomSnackbar.show(context, "Success: Updated Episode");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Dashboard()),
        );
      } else {
        String errorMessage = responseData['error'] ?? 'Unknown error occurred';
        CustomSnackbar.show(context, "Error: $errorMessage");
        print('$errorMessage');
      }
    } catch (e) {
      print('$e');
      CustomSnackbar.show(context, "Error: Failed to Update Episode. $e");
    }
  }

  void _showDeleteConfirmationDialog(String participantId, int episodeIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this episode?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
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
    var epiindex = episodeIndex + 1;
    String? userToken = await storage.read(key: 'userToken');
    var url = Uri.parse(
        'https://stresslysis.onrender.com/api/participants/$participantId/episodes/$epiindex.');
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
        'https://stresslysis.onrender.com/api/participants/${widget.participant.id}');

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
          title: const Text('Confirm Delete'),
          content: const Text(
              'Are you sure you want to delete this participant? This action cannot be undone.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Dismiss the dialog without doing anything
              },
            ),
            TextButton(
              child: const Text('Delete'),
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
