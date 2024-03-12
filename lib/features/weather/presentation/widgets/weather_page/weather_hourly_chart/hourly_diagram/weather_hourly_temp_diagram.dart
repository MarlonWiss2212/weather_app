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

    for (final hour in hourly) {
      final double unixDate = hour.dt * 1000;
      if (maxUnixDate < unixDate) {
        maxUnixDate = unixDate;
      }
      if (minUnixDate > unixDate) {
        minUnixDate = unixDate;
      }

      if (maxY < hour.temp) {
        maxY = hour.temp;
      }
      if (minY > hour.temp) {
        minY = hour.temp;
      }
      spots.add(FlSpot(unixDate, hour.temp));
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
