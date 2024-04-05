import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';
import 'package:weather_app/features/weather/presentation/widgets/general/weather_background_animation/weather_background_animation.dart';

class WeatherBackgroundAnimationWeatherPage extends StatelessWidget {
  final Widget child;
  const WeatherBackgroundAnimationWeatherPage({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final temp = context.select<WeatherProvider, double?>(
      (provider) => provider.weather?.current.temp,
    );
    final mm = context.select<WeatherProvider, double?>(
      (provider) => provider.weather?.current.rain?.oneHour,
    );
    final loading = context.select<WeatherProvider, bool>(
      (provider) => provider.loading,
    );

    if (mm == null || temp == null || loading) {
      return child;
    }

    return WeatherBackgroundAnimation(
      mmh: mm,
      temp: temp,
      child: child,
    );
  }
}
