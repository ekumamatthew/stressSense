import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stressSense_lab/theme/colors.dart';
import 'package:intl/intl.dart';

class AccountWidget extends StatefulWidget {
  const AccountWidget({Key? key}) : super(key: key);

  @override
  _AccountWidgetState createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  final FlutterSecureStorage storage = FlutterSecureStorage();
  String supervisorName = 'Loading...';
  String mail = "";
  String role = "";
  String dateTimeString = '';

  @override
  void initState() {
    super.initState();
    _loadSupervisorName();
    dateTimeString = getCurrentDateTime();
    // print('Current DateTime: $dateTimeString');
  }

  Future<void> _loadSupervisorName() async {
    String? name = await storage.read(key: 'name');
    String? email = await storage.read(key: 'email');
    String? roles = await storage.read(key: 'role');

    print(name);
    setState(() {
      supervisorName = name ?? 'Default Supervisor Name';
      mail = email ?? 'info@stresssend.lab';
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
            SizedBox(
              width: 48,
              height: 48,
              child: Image.asset('assets/images/logoImages/aiImage.png'),
            ),
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
                SizedBox(height: 5),
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
        Container(
          width: 48,
          height: 48,
          decoration: ShapeDecoration(
            color: Colors.white.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(400),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDateSection() {
    return Center(
      child: Text(
        dateTimeString, // Dynamic current date and time
        style: TextStyle(
          color: AppColor.black,
          fontSize: 10,
          fontFamily: 'Raleway',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  String getCurrentDateTime() {
    DateTime now = DateTime.now();
    // Example format: 'Today, 23rd January, 2024, 10:00 AM'
    return DateFormat('EEEE, d MMMM, yyyy, h:mm a').format(now);
  }
}
