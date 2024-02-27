import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';
import 'package:weather_app/features/weather/presentation/widgets/general/weather_visibility.dart';

class WeatherVisibilityWeatherPage extends StatelessWidget {
  const WeatherVisibilityWeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final visibility = context.select<WeatherProvider, int?>(
      (provider) => provider.weather?.current.visibility,
    );
    final loading = context.select<WeatherProvider, bool>(
      (provider) => provider.loading,
    );

    return WeatherVisibility(
      loading: loading,
      visibility: visibility,
    );
  }
}
