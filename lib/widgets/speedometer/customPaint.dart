import 'dart:math' as math;
import 'package:flutter/material.dart';

class SpeedometerPainter extends CustomPainter {
  final double value;

  SpeedometerPainter({required this.value});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2;
    final startAngle = -math.pi;
    final sweep = math.pi; // 180 degrees
    final segments = 100; // Increase for smoother gradient

    // Draw gradient dial
    for (int i = 0; i < segments; i++) {
      final segmentColor = Color.lerp(Colors.green, Colors.red, i / segments)!;
      final paintSegment = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 50
        ..color = segmentColor;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle + (sweep / segments) * i,
        sweep / segments,
        false,
        paintSegment,
      );
    }

    // Calculate the angle for the needle
    final needleAngle = startAngle + sweep * (value / 100);

    // Needle
    final paintNeedle = Paint()
      ..color = Colors.black // Color of the needle
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    // Draw needle
    canvas.drawLine(
      center,
      Offset(
        center.dx + radius * math.cos(needleAngle),
        center.dy + radius * math.sin(needleAngle),
      ),
      paintNeedle,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
