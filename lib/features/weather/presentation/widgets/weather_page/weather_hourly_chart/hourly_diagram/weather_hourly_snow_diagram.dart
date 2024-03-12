import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page/weather_hourly_chart/hourly_diagram/weather_hourly_diagram.dart';

class WeatherHourlySnowDiagram extends WeatherHourlyDiagram {
  WeatherHourlySnowDiagram({required super.hourly}) : super(minY: 0, maxY: 10);

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

      final snowOneHour = hour.snow?.oneHour ?? 0.0;
      if (maxY < snowOneHour) {
        maxY = snowOneHour;
      }
      if (minY > snowOneHour) {
        minY = snowOneHour;
      }
      spots.add(FlSpot(unixDate, snowOneHour));
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
          "${spot.y.toString()} \nmm/h",
          Theme.of(context).textTheme.labelLarge ?? const TextStyle(),
        ),
      );
    }
    return tooltips;
  }

  @override
  List<Color> getBelowGradientColors() => [
        const Color.fromARGB(255, 153, 240, 255),
        const Color.fromARGB(255, 153, 240, 255),
      ];

  @override
  List<Color> getGradientColors() => [
        const Color.fromARGB(255, 112, 212, 230),
        const Color.fromARGB(255, 112, 212, 230),
      ];
}
