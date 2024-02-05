import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/util/color_utils.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_hourly_entity.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_hourly_chart/chart_type.dart';

class WeatherHourlyChartDiagram extends StatelessWidget {
  final List<WeatherForecastHourlyEntity> hourly;
  final ChartType type;
  const WeatherHourlyChartDiagram({
    super.key,
    required this.hourly,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final parsedData = double.parse((hourly[0].dt * 1000).toString());
    double maxX = parsedData;
    double maxY = hourly[0].temp;
    double minX = parsedData;
    double minY = hourly[0].temp;
    List<FlSpot> spots = [];

    for (final hour in hourly) {
      // X is equal to date
      final innerParsed = double.parse((hour.dt * 1000).toString());
      if (minX < innerParsed) {
        minX = innerParsed;
      }
      if (maxX > innerParsed) {
        maxX = innerParsed;
      }

      switch (type) {
        case ChartType.temp:
          // Y is equal to lowest and max temp
          if (maxY < hour.temp) {
            maxY = hour.temp;
          }
          if (minY > hour.temp) {
            minY = hour.temp;
          }

          spots.add(FlSpot(innerParsed, hour.temp));
          break;
        case ChartType.clouds:
          // Y is equal to lowest and max temp
          if (maxY < hour.clouds) {
            maxY = hour.clouds.toDouble();
          }
          if (minY > hour.clouds) {
            minY = hour.clouds.toDouble();
          }
          spots.add(FlSpot(innerParsed, hour.clouds.toDouble()));
          break;

        case ChartType.rain:
          // Y is equal to lowest and max temp
          final rainOneHour = hour.rain?.oneHour ?? 0.0;
          if (maxY < rainOneHour) {
            maxY = rainOneHour;
          }
          if (minY > rainOneHour) {
            minY = rainOneHour;
          }
          spots.add(FlSpot(innerParsed, rainOneHour));
          break;
      }
    }
    minY = minY - 3;

    final lineBarData = LineChartBarData(
      spots: spots,
      isCurved: true,
      dotData: const FlDotData(show: false),
      barWidth: 6,
      curveSmoothness: .5,
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: switch (type) {
          ChartType.temp => [
              ColorUtils.colorByTemperatureLight(
                  maxY < 14 ? maxY - 3 : maxY + 3),
              ColorUtils.colorByTemperatureLight(
                  minY < 14 ? minY - 3 : minY + 3),
            ],
          ChartType.clouds => [
              const Color.fromARGB(255, 163, 163, 163),
              const Color.fromARGB(255, 163, 163, 163),
            ],
          ChartType.rain => [
              const Color.fromARGB(255, 0, 81, 202),
              const Color.fromARGB(255, 0, 81, 202),
            ],
        },
      ),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: switch (type) {
            ChartType.temp => [
                ColorUtils.colorByTemperatureLight(maxY),
                ColorUtils.colorByTemperatureLight(minY),
              ],
            ChartType.clouds => [
                const Color.fromARGB(255, 179, 179, 179),
                const Color.fromARGB(255, 179, 179, 179),
              ],
            ChartType.rain => [
                const Color.fromARGB(255, 0, 102, 255),
                const Color.fromARGB(255, 0, 102, 255),
              ],
          },
        ),
      ),
    );

    List<ShowingTooltipIndicators> showingTooltipIndicators = [];
    for (final spot in spots) {
      showingTooltipIndicators.add(
        ShowingTooltipIndicators([
          LineBarSpot(lineBarData, 0, spot),
        ]),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 3000,
          child: LineChart(
            LineChartData(
              backgroundColor: Colors.transparent,
              showingTooltipIndicators: showingTooltipIndicators,
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  tooltipBgColor: Colors.transparent,
                  tooltipPadding: const EdgeInsets.all(0),
                  tooltipMargin: 7,
                  getTooltipItems: (List<LineBarSpot> spots) {
                    List<LineTooltipItem> tooltip = [];
                    for (final spot in spots) {
                      String sign = switch (type) {
                        ChartType.temp => "°C",
                        ChartType.clouds => "%",
                        ChartType.rain => "mm/h"
                      };
                      tooltip.add(
                        LineTooltipItem(
                          "${spot.y.round().toString()} $sign",
                          const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 4,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                )
                              ]),
                        ),
                      );
                    }
                    return tooltip;
                  },
                ),
                enabled: true,
                handleBuiltInTouches: false,
              ),
              maxX: maxX,
              maxY: maxY,
              minX: minX,
              minY: minY,
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                show: true,
                topTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 70,
                    getTitlesWidget: (value, meta) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(DateFormat.Hm("de").format(
                          DateTime.fromMillisecondsSinceEpoch(value.round()),
                        )),
                      );
                    },
                  ),
                ),
                bottomTitles: const AxisTitles(
                  sideTitles: SideTitles(reservedSize: 0),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(reservedSize: 0),
                ),
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(reservedSize: 0),
                ),
              ),
              lineBarsData: [lineBarData],
            ),
          ),
        ),
      ),
    );
  }
}
