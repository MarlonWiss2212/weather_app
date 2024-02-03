import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_app_bar/weather_app_bar_delegate.dart';

class WeatherAppBar extends StatelessWidget {
  const WeatherAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: WeatherAppBarDelegate(),
    );
  }
}
