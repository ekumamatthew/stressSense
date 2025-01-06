// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:stressSense/screens/authScreens/createAccount/createAccount.dart';
import 'package:stressSense/screens/authScreens/resetPassword/resetPassword.dart';
import 'package:stressSense/screens/dashboardScreens/layout/dashboardPage.dart';
import 'package:stressSense/theme/colors.dart';
import 'package:stressSense/widgets/buttonsWidget/buttons.dart';
import 'package:stressSense/widgets/inputs/customInputs.dart';
import 'package:stressSense/widgets/loading/loading.dart';
import 'package:stressSense/widgets/loading/snacbar.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

bool _isSubmitting = false;
final storage = const FlutterSecureStorage();

class _SigninState extends State<Signin> {
  String email = '';
  String password = '';

  void _handleEmailChanged(String NewEmail) {
    setState(() {
      email = NewEmail;
    });
  }

  void _handlePasswordChanged(String newPassword) {
    setState(() {
      password = newPassword;
    });
  }

  // void _handleSubmit() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => const Dashboard()),
  //   );
  // }

  Future<void> _handleSubmit() async {
    String? newpass = password;
    String? newuser = email;

    setState(() {
      _isSubmitting = true; // Start loading
    });
    var url = Uri.parse('https://stress-bee.onrender.com/api/auth/login');
    var data = {'password': newpass, 'username': newuser};
    // print(data);
    try {
      var response = await http.post(url, body: data);

      var responseData = json.decode(response.body);
      // print(responseData);
      String? token = responseData['token'];
      String? name = responseData['user']['name'];
      String? email = responseData['user']['username'];
      String? role = responseData['user']['role'];
      String? userId = responseData['user']['_id'];

      if (responseData['success']) {
        setState(() {
          _isSubmitting = false; // Stop loading on error as well
        });
        print(responseData);
        await Future.wait([
          storage.write(key: 'userToken', value: token),
          storage.write(key: 'name', value: name),
          storage.write(key: 'email', value: email),
          storage.write(key: 'role', value: role),
          storage.write(key: 'userId', value: userId),
        ]);

        CustomSnackbar.show(context, "Suuccess: Successfully Signin");
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Dashboard()),
          (route) => false, // Removes all previous routes
        );
      } else {
        var responseData = json.decode(response.body);
        setState(() {
          _isSubmitting = false; // Stop loading on error as well
        });
        String errorMessage = responseData['error'] ?? 'Unknown error occurred';
        CustomSnackbar.show(context, "Error: $errorMessage");
      }
    } catch (e) {
      setState(() {
        _isSubmitting = false; // Stop loading on error as well
      });
      // print('Error occurred: $e');
      CustomSnackbar.show(context, "Signin Failed : $e");
      // Handle the network error, show snackbar or dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Stack(
            children: [
              if (_isSubmitting) ...[
                const Opacity(
                  opacity: 1,
                  child: ModalBarrier(dismissible: false, color: Colors.grey),
                ),
                Center(
                  child:
                      PulsingAnimationWidget(), // Or your custom loading widget
                ),
              ],
              SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
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
                          'Enter your details to access your account.',
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
                        const SizedBox(height: 100),
                        Column(
                          children: <Widget>[
                            CustomInput(
                              initialValue: email,
                              onChanged: _handleEmailChanged,
                              label: 'Enter Your email',
                              tag: 'Email',
                            ),
                            const SizedBox(
                              height: 22,
                            ),
                            CustomInput(
                              initialValue: password,
                              onChanged: _handlePasswordChanged,
                              label: 'Password',
                              tag: 'Password',
                            ),
                            const SizedBox(
                              height: 15,
                            ),

                            //  Commented out the reset button because it dosent apply in the app for now
                            
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: [
                            //     InkWell(
                            //       onTap: () {
                            //         Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //               builder: (context) =>
                            //                   const ResetPassword()),
                            //         );
                            //       },
                            //       child: const Text(
                            //         "Reset Your Password",
                            //         textAlign: TextAlign.right,
                            //         style: TextStyle(
                            //           color: AppColor.blue,
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            const SizedBox(
                              height: 200,
                            ),
                            Button1(
                                text: 'Login',
                                onPressed: _handleSubmit,
                                backgroundColor: AppColor.blue,
                                width: 357,
                                padding: const EdgeInsets.all(16),
                                textColor: AppColor.white,
                                fontFamily: 'Raleway',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                height: 1.4,
                                letterSpacing: 0.03),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Don’t have an account?',
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
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CreateAccount()),
                                );
                              },
                              child: const Text(
                                "Signup",
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
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
