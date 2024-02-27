import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';
import 'package:weather_app/features/weather/presentation/widgets/general/weather_humidity.dart';

class WeatherHumidityWeatherPage extends StatelessWidget {
  const WeatherHumidityWeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final humidity = context.select<WeatherProvider, int?>(
      (provider) => provider.weather?.current.humidity,
    );
    final loading = context.select<WeatherProvider, bool>(
      (provider) => provider.loading,
    );

    return WeatherHumidity(
      loading: loading,
      humidity: humidity,
    );
  }
}
