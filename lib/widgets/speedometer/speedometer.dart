import 'package:flutter/material.dart';
import 'package:neuroTrack/theme/colors.dart';
import 'package:neuroTrack/widgets/speedometer/customPaint.dart';

class SpeedometerWidget extends StatelessWidget {
  final double initalAverageValue;
  final double finalAverageValue;

  const SpeedometerWidget({
    super.key,
    required this.initalAverageValue,
    required this.finalAverageValue,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double widgetWidth = constraints.maxWidth * 0.4;
        double widgetHeight = widgetWidth;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                SizedBox(
                  width: widgetWidth,
                  height: widgetHeight,
                  child: CustomPaint(
                    painter: SpeedometerPainter(value: initalAverageValue),
                  ),
                ),
                Text(
                  'Stress Level Before Task: ${initalAverageValue.isFinite ? initalAverageValue.toStringAsFixed(2) : '0'}',
                  style: const TextStyle(
                    color: AppColor.gray,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              children: [
                SizedBox(
                  width: widgetWidth,
                  height: widgetHeight,
                  child: CustomPaint(
                    painter: SpeedometerPainter(value: finalAverageValue),
                  ),
                ),
                Text(
                  'Stress Level After Task: ${finalAverageValue.isFinite ? finalAverageValue.toStringAsFixed(2) : '0'}',
                  style: const TextStyle(
                    color: AppColor.gray,
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
