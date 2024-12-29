import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:neuroTrack/screens/authScreens/signin/signin.dart';
import 'package:neuroTrack/theme/colors.dart';

class AccountWidget extends StatefulWidget {
  const AccountWidget({super.key});

  @override
  _AccountWidgetState createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  String supervisorName = 'Loading...';
  String mail = "";
  String role = "";
  String dateTimeString = '';

  @override
  void initState() {
    super.initState();
    _loadSupervisorName();
    dateTimeString = getCurrentDateTime();
  }

  Future<void> _loadSupervisorName() async {
    String? name = await storage.read(key: 'name');
    String? email = await storage.read(key: 'email');
    String? roles = await storage.read(key: 'role');

    setState(() {
      supervisorName = name ?? 'Default Supervisor Name';
      mail = email ?? 'info@neurotrack.lab';
      role = roles ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.17,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        decoration: const ShapeDecoration(
          color: AppColor.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 40,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Stack(
          children: [
            buildUserInfoSection(),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: buildDateSection(), // Updated call without any arguments
            ),
          ],
        ));
  }

  Widget buildUserInfoSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
                borderRadius:
                    BorderRadius.circular(15), // Adjust the radius as needed
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: Image.asset('assets/images/logoImages/neurotrack.jpg'),
                )),
            const SizedBox(width: 10),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  role,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.02,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  supervisorName, // Dynamic supervisor name
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  mail, // Dynamic supervisor name
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.02,
                  ),
                ),
              ],
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            showLogoutConfirmation(context); // Call the logout confirmation
          },
          style: ElevatedButton.styleFrom(
            iconColor: AppColor.blue, // Background color
            backgroundColor: AppColor.white.withOpacity(0.8), // Text color
          ),
          child: const Text(
            "Logout",
            style: TextStyle(color: AppColor.blue),
          ),
        ),
      ],
    );
  }

  Future<void> showLogoutConfirmation(BuildContext context) async {
    final bool? shouldLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout', style: TextStyle(color: AppColor.white)),
          backgroundColor: AppColor.blue,
          content: const Text(
            'Are you sure you want to log out?',
            style: TextStyle(color: AppColor.white),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Don't logout
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(true); // Confirm logout
                await _logout(context); // Call the logout function
              },
              child:
                  const Text('Logout', style: TextStyle(color: AppColor.white)),
            ),
          ],
        );
      },
    );

    if (shouldLogout == true) {
      await _logout(context); // Proceed with the logout operation
    }
  }

  Widget buildDateSection() {
    return Center(
      child: Text(
        dateTimeString, // Dynamic current date and time
        style: const TextStyle(
          color: AppColor.white,
          fontSize: 10,
          fontFamily: 'Raleway',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  String getCurrentDateTime() {
    DateTime now = DateTime.now();
    return DateFormat('EEEE, d MMMM, yyyy, h:mm a').format(now);
  }

  Future<void> _logout(BuildContext context) async {
    final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

    // Assuming your logout API URL is like this
    final String apiUrl =
        'https://your-api-url.com/logout'; // Replace with your actual API URL

    try {
      // Make the API call to log out
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization':
              'Bearer ${await secureStorage.read(key: 'authToken')}', // Send the token in the request if needed
        },
      );

      if (response.statusCode == 200) {
        // If the API returns a success, delete the auth token
        await secureStorage.delete(key: 'authToken');

        // Show success message (optional)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Logged out successfully!')),
        );

        // Navigate to the SignInScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Signin()),
        );
      } else {
        // Handle API error (you can show a snackbar or dialog)
        String errorMessage =
            response.body; // Use the body of the response for error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error logging out: $errorMessage')),
        );
      }
    } catch (e) {
      // Handle network errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error logging out: $e')),
      );
    }
  }
}
