import 'package:flutter/material.dart';

class FormData {
  String email;

  FormData(
      {this.email = '',
      required String initialValue,
      required void Function(dynamic newDigit1) onChanged});
}

class OtpInput extends StatelessWidget {
  final String initialValue;
  final Function(String) onChanged;

  const OtpInput({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 54,
          child: TextFormField(
              initialValue: initialValue,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide:
                        const BorderSide(width: 1, color: Color(0xFFF0F0F0))),
              ),
              onChanged: onChanged),
        )
      ],
    );
  }
}
