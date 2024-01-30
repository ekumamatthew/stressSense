import 'package:flutter/material.dart';
import 'package:my_fizi_app/theme/colors.dart';
import 'package:my_fizi_app/widgets/inputs/customInputs.dart';

class AccountFormData {
  String fullName;
  String email;
  String password;

  AccountFormData({
    this.fullName = '',
    this.email = '',
    this.password = '',
  });
}

class AccountForm extends StatelessWidget {
  final AccountFormData formData;
  final Function(AccountFormData) onFormDataChanged;

  AccountForm({
    Key? key,
    required this.formData,
    required this.onFormDataChanged,
  }) : super(key: key);

  // Function to handle changes in the form fields and update formData
  void _handleFieldChanged(String newValue, String fieldName) {
    switch (fieldName) {
      case 'fullName':
        formData.fullName = newValue;
        break;
      case 'email':
        formData.email = newValue;
        break;
      case 'password':
        formData.password = newValue;
        break;
      default:
        break;
    }
    onFormDataChanged(formData);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Create Account',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColor.gray,
            fontSize: 28,
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.w500,
            height: 0.04,
            letterSpacing: -1.12,
          ),
        ),
        const SizedBox(height: 70),
        CustomInput(
          initialValue: formData.fullName,
          onChanged: (newValue) => _handleFieldChanged(newValue, 'fullName'),
          label: 'Enter Your Fullname',
          tag: 'FullName (Surname First)',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field cannot be empty';
            }
            return null; // return null for valid input
          },
        ),
        const SizedBox(height: 35),
        CustomInput(
          initialValue: formData.email,
          onChanged: (newValue) => _handleFieldChanged(newValue, 'email'),
          label: 'Enter your email address',
          tag: 'Email Address',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Email cannot be empty';
            } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
              return 'Please enter a valid email address';
            }
            return null; // return null for valid input
          },
        ),
        const SizedBox(height: 35),
        CustomInput(
          initialValue: formData.password,
          onChanged: (newValue) => _handleFieldChanged(newValue, 'password'),
          label: 'Enter your password',
          tag: 'Password',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field cannot be empty';
            }
            return null; // return null for valid input
          },
        ),
      ],
    );
  }
}
