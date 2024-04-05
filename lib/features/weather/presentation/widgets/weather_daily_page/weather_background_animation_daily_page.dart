import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_daily_entity.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';
import 'package:weather_app/features/weather/presentation/widgets/general/weather_background_animation/weather_background_animation.dart';

class WeatherBackgroundAnimationDailyPage extends StatelessWidget {
  final WeatherForecastDailyEntity? day;
  final Widget child;
  const WeatherBackgroundAnimationDailyPage({
    super.key,
    required this.child,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    final loading = context.select<WeatherProvider, bool>(
      (provider) => provider.loading,
    );

    if (day?.rain == null || loading) {
      return child;
    }

    return WeatherBackgroundAnimation(
      mmh: day!.rain!,
      temp: day!.temp.day,
      child: child,
    );
  }
}
