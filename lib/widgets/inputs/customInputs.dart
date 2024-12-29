import 'package:flutter/material.dart';
import 'package:neuroTrack/theme/colors.dart';

class FormData {
  String email;

  FormData({this.email = ''});
}

class CustomInput extends StatelessWidget {
  final String initialValue;
  final Function(String) onChanged;
  final String tag;
  final String label;
  final String? errorText; // Optional error text for validation
  final String? Function(String?)? validator;

  const CustomInput({
    super.key,
    required this.initialValue,
    required this.onChanged,
    required this.label,
    required this.tag,
    this.errorText, // Optional error text for validation
    this.validator, // Custom validation function
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              tag,
              style: const TextStyle(
                color: Color(0xFF2E3034),
                fontSize: 14,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w600,
                height: 0.11,
                letterSpacing: 0.03,
              ),
            ),
            const SizedBox(width: 2),
            const Text(
              '*',
              style: TextStyle(
                color: Color(0xFFEF4444),
                fontSize: 14,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w500,
                height: 0.10,
                letterSpacing: 0.03,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          initialValue: initialValue,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(width: 1, color: AppColor.blue)),
            errorText: errorText, // Display validation error text
          ),
          onChanged: onChanged,
          validator: validator,
        ),
      ],
    );
  }
}
