import 'package:flutter/material.dart';
import 'package:my_fizi_app/widgets/inputs/customInputs.dart';

class AccountForm extends StatelessWidget {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String BVN;

  AccountForm(
      {Key? key,
      this.fullName = '',
      this.email = '',
      this.phoneNumber = '',
      this.BVN = ''})
      : super(key: key);

  void _handleNameChanged(String newName) {
    // Handle Fullname change
  }

  void _handleEmailChanged(String newEmail) {
    // Handle email change
  }
  void _handlePhoneNumberChanged(String newPhoneNumber) {
    // Handle email change
  }

  void _handleBVNChanged(String newBVN) {
    // Handle email change
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Create Account',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF0E47D8),
            fontSize: 28,
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.w500,
            height: 0.04,
            letterSpacing: -1.12,
          ),
        ),
        const SizedBox(
          height: 70,
        ),
        CustomInput(
          initialValue: fullName,
          onChanged: _handleNameChanged,
          label: 'Entetr Your Fullname',
          tag: 'FullName (Surname First)',
        ),
        const SizedBox(
          height: 35,
        ),
        CustomInput(
          initialValue: email,
          onChanged: _handleEmailChanged,
          tag: 'Email Address',
          label: 'Enter your email address',
        ),
        const SizedBox(
          height: 35,
        ),
        CustomInput(
          initialValue: phoneNumber,
          onChanged: _handlePhoneNumberChanged,
          tag: 'Phone Number',
          label: 'Enter your phone number',
        ),
        const SizedBox(
          height: 35,
        ),
        CustomInput(
          initialValue: phoneNumber,
          onChanged: _handleBVNChanged,
          tag: 'BVN',
          label: 'Enter your B V N',
        ),
      ],
    );
  }
}
