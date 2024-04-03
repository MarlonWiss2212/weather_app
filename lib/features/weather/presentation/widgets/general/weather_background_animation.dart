import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/core/util/temp_utils.dart';

class WeatherBackgroundAnimation extends StatelessWidget {
  final double mmh;
  final double temp;
  final Widget child;

  const WeatherBackgroundAnimation({
    super.key,
    required this.mmh,
    required this.temp,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: TeardropPainter(
            mmh: mmh,
            temp: temp,
          ),
        ),
        child,
      ],
    );
  }
}

class TeardropPainter extends StatefulWidget {
  final double mmh;
  final double temp;

  const TeardropPainter({super.key, required this.mmh, required this.temp});

  @override
  State<TeardropPainter> createState() => _TeardropPainterState();
}

class _TeardropPainterState extends State<TeardropPainter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(minutes: 10),
    );
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return CustomPaint(
          painter: TeardropPainterWidget(
            mmh: widget.mmh,
            temp: widget.temp,
            yOffset: _controller.value,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class TeardropPainterWidget extends CustomPainter {
  final double mmh;
  final double temp;
  final double yOffset;
  final int numDrops;
  final double dropSize = 8;

  TeardropPainterWidget({
    required this.mmh,
    required this.temp,
    required this.yOffset,
  }) : numDrops = (mmh * 150).toInt(); // Adjust the density of teardrops

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = TempUtils.colorForPrecipitationByTemp(
        temp,
      ).withOpacity(.5);
    final Random random = Random();

    for (int i = 0; i < numDrops; i++) {
      final double x = random.nextDouble() * size.width;
      final double y =
          yOffset * size.height + random.nextDouble() * size.height;

      canvas.drawOval(
        Rect.fromLTWH(x, y, dropSize, dropSize * 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(TeardropPainterWidget oldDelegate) {
    return oldDelegate.yOffset != yOffset;
  }
}
