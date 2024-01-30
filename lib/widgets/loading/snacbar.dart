// custom_snackbar.dart
import 'package:flutter/material.dart';
import 'package:my_fizi_app/theme/colors.dart';

class CustomSnackbar {
  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          height: 40,
          width: double.maxFinite, // Set your desired height here
          child: Center(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20, // You can adjust the font size as well
              ),
            ),
          ),
        ),
        duration: const Duration(seconds: 4),
        backgroundColor: AppColor.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(horizontal: 50),
      ),
    );
  }
}
