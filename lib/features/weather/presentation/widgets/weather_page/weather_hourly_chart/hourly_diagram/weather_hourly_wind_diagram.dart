import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page/weather_hourly_chart/hourly_diagram/weather_hourly_diagram.dart';

class WeatherHourlyWindDiagram extends WeatherHourlyDiagram {
  WeatherHourlyWindDiagram({required super.hourly}) : super(minY: 0, maxY: 15);

  @override
  List<FlSpot> generateSpotsList() {
    List<FlSpot> spots = [];

    for (final hour in hourly) {
      final double unixDate = hour.dt * 1000;
      if (maxUnixDate < unixDate) {
        maxUnixDate = unixDate;
      }
      if (minUnixDate > unixDate) {
        minUnixDate = unixDate;
      }

      if (maxY < hour.windSpeed) {
        maxY = hour.windSpeed;
      }
      if (minY > hour.windSpeed) {
        minY = hour.windSpeed;
      }
      spots.add(FlSpot(unixDate, hour.windSpeed));
    }

    return spots;
  }

  @override
  List<LineTooltipItem?> getTooltipItems(
    BuildContext context,
    List<LineBarSpot> spots,
  ) {
    List<LineTooltipItem> tooltips = [];
    for (final spot in spots) {
      tooltips.add(
        LineTooltipItem(
          "${spot.y.toString()} \nm/s",
          Theme.of(context).textTheme.labelLarge ?? const TextStyle(),
        ),
      );
    }
    return tooltips;
  }

  @override
  List<Color> getBelowGradientColors() => [
        const Color.fromARGB(255, 179, 179, 179),
        const Color.fromARGB(255, 179, 179, 179),
      ];

  @override
  List<Color> getGradientColors() => [
        const Color.fromARGB(255, 163, 163, 163),
        const Color.fromARGB(255, 163, 163, 163),
      ];
}
