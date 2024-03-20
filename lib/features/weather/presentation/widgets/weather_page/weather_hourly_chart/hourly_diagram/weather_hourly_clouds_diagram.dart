import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page/weather_hourly_chart/hourly_diagram/weather_hourly_diagram.dart';

class WeatherHourlyCloudsDiagram extends WeatherHourlyDiagram {
  WeatherHourlyCloudsDiagram({required super.hourly})
      : super(minY: 0, maxY: 100);

  @override
  List<FlSpot> generateSpotsList() {
    List<FlSpot> spots = [];

    for (int index = 0; index < hourly.length - 1; index++) {
      final hour = hourly[index];

      if (maxIndex < index) {
        maxIndex = index.toDouble();
      }
      if (minIndex > index) {
        maxIndex = index.toDouble();
      }

      if (maxY < hour.clouds) {
        maxY = hour.clouds.toDouble();
      }
      if (minY > hour.clouds) {
        minY = hour.clouds.toDouble();
      }

      spots.add(FlSpot(index.toDouble(), hour.clouds.toDouble()));
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
          "${spot.y.round().toString()} %",
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
