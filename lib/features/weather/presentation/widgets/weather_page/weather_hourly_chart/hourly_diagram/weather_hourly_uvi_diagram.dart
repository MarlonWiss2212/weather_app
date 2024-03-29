import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/core/util/uv_utils.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page/weather_hourly_chart/hourly_diagram/weather_hourly_diagram.dart';

class WeatherHourlyUviDiagram extends WeatherHourlyDiagram {
  WeatherHourlyUviDiagram({required super.hourly}) : super(minY: 0, maxY: 0);

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

      if (maxY < hour.uvi) {
        maxY = hour.uvi;
      }
      if (minY > hour.uvi) {
        minY = hour.uvi;
      }
      spots.add(FlSpot(index.toDouble(), hour.uvi));
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
          "${spot.y.toString()} \n${UvUtils.uvIndex(spot.y)}",
          Theme.of(context).textTheme.labelLarge ?? const TextStyle(),
        ),
      );
    }
    return tooltips;
  }

  @override
  List<Color> getBelowGradientColors() => [
        UvUtils.colorByUvIndex(maxY),
        UvUtils.colorByUvIndex(minY),
      ];

  @override
  List<Color> getGradientColors() => [
        UvUtils.colorByUvIndex(maxY + 1),
        UvUtils.colorByUvIndex(minY + 1),
      ];
}
