import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/core/util/temp_utils.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page/weather_hourly_chart/hourly_diagram/weather_hourly_diagram.dart';

class WeatherHourlyTempDiagram extends WeatherHourlyDiagram {
  WeatherHourlyTempDiagram({required super.hourly})
      : super(minY: double.infinity, maxY: double.negativeInfinity);

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

      if (maxY < hour.temp) {
        maxY = hour.temp;
      }
      if (minY > hour.temp) {
        minY = hour.temp;
      }
      spots.add(FlSpot(index.toDouble(), hour.temp));
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
          "${spot.y.round().toString()} °C",
          Theme.of(context).textTheme.labelLarge ?? const TextStyle(),
        ),
      );
    }
    return tooltips;
  }

  @override
  List<Color> getBelowGradientColors() => [
        TempUtils.colorByTemperatureLight(maxY),
        TempUtils.colorByTemperatureLight(minY),
      ];

  @override
  List<Color> getGradientColors() => [
        TempUtils.colorByTemperatureLight(
          maxY < 14 ? maxY - 3 : maxY + 3,
        ),
        TempUtils.colorByTemperatureLight(
          minY < 14 ? minY - 3 : minY + 3,
        ),
      ];
}
