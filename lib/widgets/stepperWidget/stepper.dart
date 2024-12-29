// // ignore_for_file: use_build_context_synchronously

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:neuroTrack/screens/authScreens/signin/signin.dart';
// import 'package:neuroTrack/theme/colors.dart';
// import 'package:neuroTrack/widgets/buttonsWidget/buttons.dart';
// import 'package:neuroTrack/widgets/loading/loading.dart';
// import 'package:neuroTrack/widgets/loading/snacbar.dart';

// class SignupPage extends StatefulWidget {
//   const SignupPage({super.key});

//   @override
//   _SignupPageState createState() => _SignupPageState();
// }

// class _SignupPageState extends State<SignupPage> {
//   final _formKey = GlobalKey<FormState>();
//   bool _isSubmitting = false;

//   // Form fields
//   String? fullName;
//   String? email;
//   String? password;

//   Future<void> submitUserData() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() {
//       _isSubmitting = true; // Start loading
//     });

//     var data = {
//       'name': fullName,
//       'password': password,
//       'username': email,
//     };

//     var url = Uri.parse('https://stress-bee.onrender.com/api/auth/register');
//     try {
//       var response = await http.post(url, body: data);
//       var successResponse = json.decode(response.body);

//       if (successResponse['success'] == true) {
//         setState(() {
//           _isSubmitting = false; // Stop loading
//         });
//         CustomSnackbar.show(context, "Success: Successfully signed up");
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const Signin()),
//         );
//       } else {
//         String errorMessage =
//             successResponse['error']['_message'] ?? 'Unknown error occurred';
//         CustomSnackbar.show(context, "Error: $errorMessage");
//       }
//     } catch (e) {
//       CustomSnackbar.show(context, "Signup Failed: $e");
//     } finally {
//       setState(() {
//         _isSubmitting = false; // Stop loading
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size screenSize = MediaQuery.of(context).size;

//     return Scaffold(
//       body: SafeArea(
//         child: Stack(
//           children: [
//             if (_isSubmitting) ...[
//               const Opacity(
//                 opacity: 1,
//                 child: ModalBarrier(dismissible: false, color: Colors.grey),
//               ),
//               Center(
//                 child: PulsingAnimationWidget(),
//               ),
//             ],
//             SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(height: 50),
//                       const Text(
//                         "Sign Up",
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 30),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: "Full Name",
//                           border: OutlineInputBorder(),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return "Full name is required";
//                           }
//                           return null;
//                         },
//                         onChanged: (value) => fullName = value,
//                       ),
//                       const SizedBox(height: 20),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: "Email",
//                           border: OutlineInputBorder(),
//                         ),
//                         keyboardType: TextInputType.emailAddress,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return "Email is required";
//                           } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
//                             return "Enter a valid email address";
//                           }
//                           return null;
//                         },
//                         onChanged: (value) => email = value,
//                       ),
//                       const SizedBox(height: 20),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: "Password",
//                           border: OutlineInputBorder(),
//                         ),
//                         obscureText: true,
//                         validator: (value) {
//                           if (value == null || value.length < 6) {
//                             return "Password must be at least 6 characters";
//                           }
//                           return null;
//                         },
//                         onChanged: (value) => password = value,
//                       ),
//                       const SizedBox(height: 30),
//                       Button1(
//                         text: "Sign Up",
//                         onPressed: submitUserData,
//                         backgroundColor: AppColor.blue,
//                         width: screenSize.width - 32,
//                         padding: const EdgeInsets.all(16),
//                         textColor: AppColor.white,
//                         fontFamily: 'Raleway',
//                         fontSize: 16.0,
//                         fontWeight: FontWeight.w600,
//                       ),
//                       const SizedBox(height: 30),
//                       _buildSignInLink(context),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSignInLink(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Text(
//           'Already have an account?',
//         ),
//         InkWell(
//           onTap: () => Navigator.push(
//               context, MaterialPageRoute(builder: (context) => const Signin())),
//           child: const Text(
//             " Log in",
//             style: TextStyle(
//               color: Colors.blue,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
