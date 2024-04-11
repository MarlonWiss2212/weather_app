import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weather_app/core/util/temp_utils.dart';

class TeardropPainterWidget extends CustomPainter {
  final double mmhRain;
  final double mmhSnow;
  final double temp;
  final List<Offset> raindrops;
  final List<Offset> snowflakes;
  final double raindropAndSnowflakeSize;
  TeardropPainterWidget({
    required this.raindrops,
    required this.snowflakes,
    required this.mmhRain,
    required this.mmhSnow,
    required this.temp,
    required this.raindropAndSnowflakeSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _paintSnowDrops(canvas, size);
    _paintRainDrops(canvas, size);
  }

  void _paintSnowDrops(Canvas canvas, Size size) {
    Random random = Random();
    final Paint paint = Paint()
      ..color = TempUtils.colorForPrecipitationByTemp(temp)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    for (final flake in snowflakes) {
      final double x = flake.dx * size.width;
      final double y = flake.dy * size.height;

      final double armLength = raindropAndSnowflakeSize;
      const double armAngleIncrement =
          2 * pi / 6; // 6 arms for a typical snowflake

      final double rotationAngle = random.nextDouble() * pi;

      Path path = Path();
      for (double angle = 0; angle < 2 * pi; angle += armAngleIncrement) {
        final double rotatedAngle = angle + rotationAngle;
        final double xOffset = armLength * cos(rotatedAngle);
        final double yOffset = armLength * sin(rotatedAngle);

        path.moveTo(x, y);
        path.lineTo(x + xOffset, y + yOffset);
      }

      path.close();

      canvas.drawPath(path, paint);
    }
  }

  void _paintRainDrops(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = TempUtils.colorForPrecipitationByTemp(temp);
    for (final drop in raindrops) {
      final double x = drop.dx * size.width;
      final double y = drop.dy * size.height;

      final double dropWidth = raindropAndSnowflakeSize * 0.7;
      final double dropHeight = raindropAndSnowflakeSize * 2.5;
      final double controlPointOffset = dropWidth * 0.6;

      Path path = Path()
        ..moveTo(x, y - dropHeight)
        ..quadraticBezierTo(
            x + controlPointOffset, y - dropHeight * 0.4, x + dropWidth / 2, y)
        ..quadraticBezierTo(x, y + dropHeight * 0.6, x - dropWidth / 2, y)
        ..quadraticBezierTo(
            x - controlPointOffset, y - dropHeight * 0.4, x, y - dropHeight);

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(TeardropPainterWidget oldDelegate) {
    return oldDelegate.raindrops != raindrops ||
        oldDelegate.snowflakes != snowflakes;
  }
}
