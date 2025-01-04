import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:stressSense/screens/authScreens/signin/signin.dart'; // For navigation
import 'package:stressSense/theme/colors.dart';
import 'package:stressSense/widgets/buttonsWidget/buttons.dart';
import 'package:stressSense/widgets/loading/loading.dart'; // PulsingAnimationWidget
import 'package:stressSense/widgets/loading/snacbar.dart'; // CustomSnackbar

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  String fullName = '';
  String email = '';
  String password = '';

  Future<void> submitUserData() async {
    setState(() {
      _isSubmitting = true; // Start loading
    });

    var data = {'name': fullName.toLowerCase(), 'password': password, 'username': email};
    var url = Uri.parse('https://stress-bee.onrender.com/api/auth/register');

    try {
      var response = await http.post(url, body: data);
      var successResponse = json.decode(response.body);

      if (successResponse['success'] == true) {
        setState(() {
          _isSubmitting = false; // Stop loading on success
        });
        CustomSnackbar.show(context, "Success: Successfully Signed Up");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Signin()),
        );
      } else {
        setState(() {
          _isSubmitting = false; // Stop loading on error
        });
        String errorMessage =
            successResponse['error'] ?? 'Unknown error occurred';
        CustomSnackbar.show(context, "Error: $errorMessage");
      }
    } catch (e) {
      setState(() {
        _isSubmitting = false; // Stop loading on error
      });
      CustomSnackbar.show(context, "Signup Failed: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            if (_isSubmitting) ...[
              const Opacity(
                opacity: 1,
                child: ModalBarrier(dismissible: false, color: Colors.grey),
              ),
              const Center(
                child: PulsingAnimationWidget(),
              ),
            ],
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  const Text(
                    'Welcome Back',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColor.blue,
                      fontSize: 28,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.w500,
                      // height: 0.04,
                      letterSpacing: -1.12,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Enter your details to creat your account.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF2E3034),
                      fontSize: 14,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w500,
                      height: 0.10,
                      letterSpacing: 0.03,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 50),
                        const Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColor.blue),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Username",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "username is required";
                            }
                            return null;
                          },
                          onChanged: (value) => fullName = value,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email is required";
                            } else if (!RegExp(r'\S+@\S+\.\S+')
                                .hasMatch(value)) {
                              return "Enter a valid email address";
                            }
                            return null;
                          },
                          onChanged: (value) => email = value,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder(),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.length < 6) {
                              return "Password must be at least 6 characters";
                            }
                            return null;
                          },
                          onChanged: (value) => password = value,
                        ),
                        const SizedBox(height: 30),
                        Button1(
                          text: 'Sign Up',
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              submitUserData();
                            }
                          },
                          backgroundColor: AppColor
                              .blue, // Adjust the color based on your app's theme
                          width: 357,
                          padding: const EdgeInsets.all(16),
                          textColor:
                              AppColor.white, // Text color for the button
                          fontFamily: 'Raleway',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                          letterSpacing: 0.03,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 70),
                  _buildSignInLink(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignInLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Already have an account?',
                    style: TextStyle(
                      color: AppColor.gray,
                      fontSize: 16,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w500,
                      height: 0.10,
                      letterSpacing: 0.03,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Signin()),
                );
              },
              child: const Text(
                "Signin",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColor.blue,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
