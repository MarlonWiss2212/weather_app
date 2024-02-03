import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_hourly_entity.dart';

class WeatherHourlyChart extends StatelessWidget {
  final List<WeatherForecastHourlyEntity> hourly;
  final bool rainChart;
  const WeatherHourlyChart({
    super.key,
    required this.hourly,
    required this.rainChart,
  });

  Widget _rainChart(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(),
        ],
      ),
    );
  }

  Widget _temperatureChart(BuildContext context) => const Placeholder();

  @override
  Widget build(BuildContext context) {
    return rainChart ? _rainChart(context) : _temperatureChart(context);
  }
}
