import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:stressSense/screens/dashboardScreens/layout/dashboardPage.dart';
import 'package:stressSense/theme/colors.dart';
import 'package:stressSense/widgets/inputs/customInputs.dart';
import 'package:stressSense/widgets/loading/loading.dart';
import 'package:stressSense/widgets/loading/snacbar.dart';

class AddParticipantScreen extends StatefulWidget {
  const AddParticipantScreen({super.key});

  @override
  _AddParticipantScreenState createState() => _AddParticipantScreenState();
}

class _AddParticipantScreenState extends State<AddParticipantScreen> {
  final _formKey = GlobalKey<FormState>();
  String participant = '';
  bool _isSubmitting = false;
  final storage = const FlutterSecureStorage();
  // Other participant attributes as needed
  void _handleNameChanged(String newParticipant) {
    setState(() {
      participant = newParticipant;
    });
  }

  void _saveParticipant() async {
    String? userToken = await storage.read(key: 'userToken');
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Perform the async operation
      setState(() {
        _isSubmitting = true; // Start loading
      });
      var url = Uri.parse('https://stress-bee.onrender.com/api/participants');

      var data = {'name': participant.toLowerCase()};

      try {
        var response = await http.post(
          url,
          body: data,
          headers: {'Authorization': 'Bearer $userToken'},
        );

        var responseData = json.decode(response.body);
        if (responseData['success']) {
          setState(() {
            _isSubmitting = false; // Stop loading on error as well
          });

          CustomSnackbar.show(context, "Suuccess: Mermber Added");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Dashboard()),
          );
        } else {
          var responseData = json.decode(response.body);
          setState(() {
            _isSubmitting = false; // Stop loading on error as well
          });
          print(response);
          String errorMessage =
              responseData['error'] ?? 'Unknown error occurred';
          CustomSnackbar.show(context, "Error: $errorMessage");
        }
      } catch (e) {
        setState(() {
          _isSubmitting = false; // Stop loading on error as well
        });
        // print('Error occurred: $e');
        CustomSnackbar.show(context, "Upload Failed : $e");
        // Handle the network error, show snackbar or dialog
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Member'),
      ),
      body: Stack(children: [
        if (_isSubmitting) ...[
          const Opacity(
            opacity: 1,
            child: ModalBarrier(dismissible: false, color: Colors.grey),
          ),
          Center(
            child: PulsingAnimationWidget(), // Or your custom loading widget
          ),
        ],
        SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  CustomInput(
                    initialValue: participant,
                    onChanged: _handleNameChanged,
                    label: 'Member',
                    tag: 'Member Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null; // null means no error
                    },
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  ElevatedButton(
                    onPressed: _saveParticipant,
                    child: const Text(
                      'Save Member',
                      style: TextStyle(color: AppColor.blue),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
