import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_daily_entity.dart';

class WeatherDailyPage extends StatelessWidget {
  final WeatherForecastDailyEntity day;

  const WeatherDailyPage({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        title: const Text(""),
      ),
      body: const WeatherMapFullscreenBox(),
    );
  }
}
