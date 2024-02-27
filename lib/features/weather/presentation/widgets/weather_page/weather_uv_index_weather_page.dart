import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';
import 'package:weather_app/features/weather/presentation/widgets/general/weather_uv_index.dart';

class WeatherUVIndexWeatherPage extends StatelessWidget {
  const WeatherUVIndexWeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final uvIndex = context.select<WeatherProvider, double?>(
      (provider) => provider.weather?.current.uvi,
    );
    final loading = context.select<WeatherProvider, bool>(
      (provider) => provider.loading,
    );

    return WeatherUVIndex(
      uvIndex: uvIndex,
      loading: loading,
    );
  }
}
