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
    final mmRain = context.select<WeatherProvider, double?>(
      (provider) => provider.weather?.current.rain?.oneHour,
    );
    final mmSnow = context.select<WeatherProvider, double?>(
      (provider) => provider.weather?.current.snow?.oneHour,
    );
    final loading = context.select<WeatherProvider, bool>(
      (provider) => provider.loading,
    );

    if (loading || temp == null || (mmRain == null && mmSnow == null)) {
      return child;
    }

    return WeatherBackgroundAnimation(
      mmhRain: mmRain ?? 0,
      mmhSnow: mmSnow ?? 0,
      temp: temp,
      child: child,
    );
  }
}
