import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_hourly_entity.dart';

abstract class WeatherHourlyDiagram {
  final List<WeatherForecastHourlyEntity> hourly;
  late double maxIndex;
  double maxY;
  late double minIndex;
  double minY;

  WeatherHourlyDiagram({
    required this.hourly,
    required this.maxY,
    required this.minY,
  }) {
    maxIndex = 0;
    minIndex = 0;
  }
  List<FlSpot> generateSpotsList();
  List<Color> getGradientColors();
  List<Color> getBelowGradientColors();
  List<LineTooltipItem?> getTooltipItems(
    BuildContext context,
    List<LineBarSpot> spots,
  );
}
