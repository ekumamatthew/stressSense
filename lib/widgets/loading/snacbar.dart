// custom_snackbar.dart

/**
 * This page is the notification that pop when  there is an error or a succesful activity
 */

import 'package:flutter/material.dart';
import 'package:stressSense/theme/colors.dart';

class CustomSnackbar {
  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: SizedBox(
          height: 40,
          width: double.maxFinite, // Set your desired height here
          child: Center(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
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
        margin: const EdgeInsets.symmetric(horizontal: 50),
      ),
    );
  }
}
