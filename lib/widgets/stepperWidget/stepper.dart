// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_fizi_app/data/disclaimer.dart';
import 'package:my_fizi_app/screens/authScreens/createAccount/component/createAccountForm.dart';
import 'package:my_fizi_app/screens/authScreens/signin/signin.dart';
import 'package:my_fizi_app/theme/colors.dart';
import 'package:my_fizi_app/widgets/buttonsWidget/buttons.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_fizi_app/widgets/loading/loading.dart';
import 'package:my_fizi_app/widgets/loading/snacbar.dart';

class StepperForm extends StatefulWidget {
  final int currentStep;

  StepperForm({
    super.key,
    this.currentStep = 0,
  });

  @override
  _StepperFormState createState() => _StepperFormState();
}

class _StepperFormState extends State<StepperForm> {
  final _formKey = GlobalKey<FormState>();
  late int _currentStep;
  bool _isSubmitting = false;
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  AccountFormData formData = AccountFormData();
  bool _isSubmitted = false;
  @override
  void initState() {
    super.initState();
    _currentStep = widget.currentStep;
  }

  void _updateFormData(AccountFormData newData) {
    setState(() {
      formData = newData;
    });
  }

  void _goToNextStep() async {
    if (_currentStep < _mySteps().length - 1) {
      if (_currentStep == 0 && _formKey.currentState!.validate()) {
        // Form is valid, proceed to the next step
        await _secureStorage.write(key: 'fullName', value: formData.fullName);
        // ... store other form data ...
      } else {
        return; // Form is invalid, stop here
      }
      setState(() {
        _currentStep++;
      });
    } else {
      submitUserData(formData);
    }
  }

  Future<void> submitUserData(AccountFormData formData) async {
    setState(() {
      _isSubmitting = true; // Start loading
    });
    String? password = formData.password;
    String? email = formData.email;
    String? name = formData.fullName;

    var data = {'name': name, 'password': password, 'username': email};
    // print(data);
    var url = Uri.parse(
        'https://stresslysis.onrender.com/api/auth/register'); // Adjust the endpoint as necessary
    try {
      var response = await http.post(url, body: data);
      var successResponse = json.decode(response.body);

      // print(successResponse);
      if (successResponse['success'] == true) {
        setState(() {
          _isSubmitting = false; // Stop loading on error as well
        });
        // print(successResponse);
        CustomSnackbar.show(context, "Suuccess: Successfully Signeup");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Signin()),
        );
      } else {
        var responseData = json.decode(response.body);
        String errorMessage =
            responseData['error']['_message'] ?? 'Unknown error occurred';
        CustomSnackbar.show(context, "Error: $errorMessage");
      }
    } catch (e) {
      // print(e);
      CustomSnackbar.show(context, "Signup Failed : $e");
      setState(() {
        _isSubmitting = false; // Stop loading on error as well
      });
    } finally {
      setState(() {
        _isSubmitting = false; // Stop loading on error as well
      });
    }
  }

  List<Step> _mySteps() {
    return [
      Step(
        title: Text('Step 1'), // title is now a Widget
        content: AccountForm(
          formData: formData,
          onFormDataChanged: _updateFormData,
        ),
      ),
      Step(
        title: Text('Step 2'), // title is now a Widget
        content: DisclaimerPage(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: screenSize.width, // Set width to device width
          height: screenSize.height, // Set height to device height
          child: Stack(
            children: [
              if (_isSubmitting) ...[
                Opacity(
                  opacity: 1,
                  child: ModalBarrier(dismissible: false, color: Colors.grey),
                ),
                Center(
                  child:
                      PulsingAnimationWidget(), // Or your custom loading widget
                ),
              ],
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    // Wrap with Form widget
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 50),
                        _mySteps()[_currentStep].content,
                        const SizedBox(height: 50),
                        Button1(
                          text: _currentStep < _mySteps().length - 1
                              ? "Continue →"
                              : "Finish",
                          onPressed: _goToNextStep,
                          backgroundColor: AppColor.blue,
                          width: 375.0,
                          padding: const EdgeInsets.all(20),
                          textColor: AppColor.white,
                          fontFamily: 'Raleway',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                          letterSpacing: 0.032,

                          // Other Button1 properties...
                        ),
                        const SizedBox(height: 30),
                        _buildSignInLink(context),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignInLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account?',
          // Text style properties...
        ),
        InkWell(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Signin())),
          child: const Text(
            "Log in",
            // Text style properties...
          ),
        ),
      ],
    );
  }
}
