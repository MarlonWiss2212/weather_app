import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/features/weather/presentation/widgets/general/weather_background_animation/teardrop_painter.dart';

class WeatherBackgroundAnimation extends StatelessWidget {
  final double mmh;
  final double temp;
  final Widget child;

  const WeatherBackgroundAnimation({
    Key? key,
    required this.mmh,
    required this.temp,
    required this.child,
  }) : super(key: key);

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
