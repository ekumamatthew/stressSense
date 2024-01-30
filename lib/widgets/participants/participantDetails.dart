// file: lib/screens/participant_detail_screen.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_fizi_app/data/participants.dart';
import 'package:http/http.dart' as http;
import 'package:my_fizi_app/widgets/loading/loading.dart';
import 'package:my_fizi_app/widgets/loading/snacbar.dart';
// class ParticipantDetailScreen extends StatelessWidget {
//   final ParticipantData participant;

//   const ParticipantDetailScreen({Key? key, required this.participant})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(participant.name),
//       ),
//       body: ListView(
//         children: participant.episodes.map((episode) {
//           return ListTile(
//             title: Text('Episode $episode.episodeNumber'),
//             subtitle: Text('STAI: ${episode.stai}, NASA: ${episode.nasa}'),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }

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

  void handleStaiChange(String value) {
    setState(() {
      _stai = value;
    });
  }

  void _submitForm() async {
    // String? STAI = _stai;
    // String? NASA = _nasa;
    String? userToken = await storage.read(key: 'userToken');
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // print('STAI: $_stai, NASA: $_nasa');

      var url = Uri.parse(
          'https://stresslysis.onrender.com/api/participants/${widget.participant.id}/episodes');
      var data = {'NASA': _nasa, 'STAI': _stai};
      // print(data);
      try {
        var response = await http.post(
          url,
          body: {'NASA': "$_nasa", 'STAI': "$_stai"},
          headers: {'Authorization': 'Bearer $userToken'},
        );
        var responseData = json.decode(response.body);
        if (responseData['success']) {
          CustomSnackbar.show(context, "Suuccess: Participant Added");
          Navigator.pop(context);
          // await _fetchParticipants();
        } else {
          var responseData = json.decode(response.body);
          // print(response);
          String errorMessage =
              responseData['error'] ?? 'Unknown error occurred';
          CustomSnackbar.show(context, "Error: $errorMessage");
        }
      } catch (e) {
        print('Error occurred: $e');
        CustomSnackbar.show(context, "Upload Failed : $e");
      }

      // You may want to call setState to update the UI or navigate away
    }

    // print(widget.participant.id);
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
                        TextFormField(
                          decoration: InputDecoration(labelText: 'STAI Value'),
                          keyboardType:
                              TextInputType.text, // Changed to text input type
                          onChanged: handleStaiChange,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid STAI value';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'NASA Value'),
                          keyboardType:
                              TextInputType.text, // Changed to text input type
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
                return Column(
                  children: [
                    ListTile(
                      // title: Text('Episode ${episode}'),
                      subtitle: Text(
                          'STAI: ${episode.stai.toStringAsFixed(2)},  NASA: ${episode.nasa.toStringAsFixed(2)}'),
                    ),
                    if (index == widget.participant.episodes.length - 1 &&
                        widget.participant.episodes.isNotEmpty)
                      ElevatedButton(
                        onPressed: _handleDelete,
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
        CustomSnackbar.show(context, "Suuccess: Deleted Participant");
        Navigator.pop(context);
      } else {
        var responseData = json.decode(response.body);
        String errorMessage = responseData['error'] ?? 'Unknown error occurred';
        CustomSnackbar.show(context, "Error: $errorMessage");
      }
    } catch (e) {
      // print('Error occurred: $e');
      CustomSnackbar.show(context, "Error: Failed to Delete");
    }

    // You may want to call setState to update the UI or navigate away
  }
}
