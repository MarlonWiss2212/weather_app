import 'package:flutter/material.dart';

class WeatherIcon extends StatelessWidget {
  final double? size;
  const WeatherIcon({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    //TODO: implement component with custom icons
    return Icon(
      Icons.abc,
      size: size,
    );
  }
}
