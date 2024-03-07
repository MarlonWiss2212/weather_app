import 'package:flutter/material.dart';
import 'package:weather_app/core/util/icon_utils.dart';

class WeatherIcon extends StatelessWidget {
  final String iconCode;
  final double? size;
  final bool snow;
  const WeatherIcon({
    super.key,
    required this.iconCode,
    this.size,
    this.snow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      IconUtils.getIconByWeatherMapIconCode(
        iconCode,
        snow: snow,
      ),
      size: size,
    );
  }
}
