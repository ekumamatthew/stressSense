import 'package:flutter/material.dart';

class Button1 extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final double width;
  final EdgeInsets padding;
  final Color textColor;
  final String fontFamily;
  final double fontSize;
  final FontWeight fontWeight;
  final double height;
  final double letterSpacing;

  final Color? borderColor;

  const Button1({
    super.key,
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    required this.width,
    required this.padding,
    required this.textColor,
    required this.fontFamily,
    required this.fontSize,
    required this.fontWeight,
    required this.height,
    required this.letterSpacing,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: padding,
          side: borderColor != null
              ? BorderSide(color: borderColor!, width: 2.0)
              : BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontFamily: fontFamily,
            fontSize: fontSize,
            fontWeight: fontWeight,
            height: height,
            letterSpacing: letterSpacing,
          ),
        ),
      ),
    );
  }
}
