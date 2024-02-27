import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';
import 'package:weather_app/features/weather/presentation/widgets/general/weather_wind.dart';

class WeatherWindWeatherPage extends StatelessWidget {
  const WeatherWindWeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final windSpeed = context.select<WeatherProvider, double?>(
      (provider) => provider.weather?.current.windSpeed,
    );
    final windDeg = context.select<WeatherProvider, int?>(
      (provider) => provider.weather?.current.windDeg,
    );
    final loading = context.select<WeatherProvider, bool>(
      (provider) => provider.loading,
    );

    return WeatherWind(
      loading: loading,
      windDeg: windDeg,
      windSpeed: windSpeed,
    );
  }
}
