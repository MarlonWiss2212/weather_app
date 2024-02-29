import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_daily_entity.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';
import 'package:weather_app/features/weather/presentation/widgets/general/weather_uv_index.dart';

class WeatherUVIndexDailyPage extends StatelessWidget {
  final WeatherForecastDailyEntity? day;
  const WeatherUVIndexDailyPage({
    super.key,
    this.day,
  });

  @override
  Widget build(BuildContext context) {
    final loading = context.select<WeatherProvider, bool>(
      (provider) => provider.loading,
    );

    return WeatherUVIndex(
      uvIndex: day?.uvi,
      loading: loading,
    );
  }
}
