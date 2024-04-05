import 'package:flutter/material.dart';
import 'package:weather_app/core/util/temp_utils.dart';

class TeardropPainterWidget extends CustomPainter {
  final double mmh;
  final double temp;
  final List<Offset> drops;
  final double dropSize;
  TeardropPainterWidget({
    required this.drops,
    required this.mmh,
    required this.temp,
    required this.dropSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = TempUtils.colorForPrecipitationByTemp(temp);

    for (var drop in drops) {
      final double x = drop.dx * size.width;
      final double y = drop.dy * size.height;

      final double dropWidth = dropSize * 0.7;
      final double dropHeight = dropSize * 2.5;
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
    return oldDelegate.drops != drops;
  }
}
