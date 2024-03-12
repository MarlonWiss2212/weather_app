import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_hourly_entity.dart';

abstract class WeatherHourlyDiagram {
  final List<WeatherForecastHourlyEntity> hourly;
  late double maxUnixDate;
  double maxY;
  late double minUnixDate;
  double minY;

  WeatherHourlyDiagram({
    required this.hourly,
    required this.maxY,
    required this.minY,
  }) {
    final double firstDateOfHourly = hourly[0].dt * 1000;
    maxUnixDate = firstDateOfHourly;
    minUnixDate = firstDateOfHourly;
  }

  List<FlSpot> generateSpotsList();
  List<Color> getGradientColors();
  List<Color> getBelowGradientColors();
  List<LineTooltipItem?> getTooltipItems(
    BuildContext context,
    List<LineBarSpot> spots,
  );
}
