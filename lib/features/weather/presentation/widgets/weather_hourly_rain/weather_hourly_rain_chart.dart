import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_hourly_entity.dart';

class WeatherHourlyRainChart extends StatelessWidget {
  final List<WeatherForecastHourlyEntity> hourly;
  const WeatherHourlyRainChart({super.key, required this.hourly});

  @override
  Widget build(BuildContext context) {
    final parsedData = double.parse((hourly[0].dt * 1000).toString());
    double maxX = parsedData;
    double maxY = hourly[0].temp;
    double minX = parsedData;
    double minY = hourly[0].temp;
    List<FlSpot> spots = [];

    for (final hour in hourly) {
      // Y is equal to lowest and max temp
      if (maxY < hour.temp) {
        maxY = hour.temp;
      }
      if (minY > hour.temp) {
        minY = hour.temp;
      }

      // X is equal to date
      final innerParsed = double.parse((hour.dt * 1000).toString());
      if (minX < innerParsed) {
        minX = innerParsed;
      }
      if (maxX > innerParsed) {
        maxX = innerParsed;
      }

      spots.add(FlSpot(innerParsed, hour.temp));
    }
    minY = minY - 3;

    final lineBarData = LineChartBarData(
      spots: spots,
      isCurved: true,
      dotData: const FlDotData(show: false),
      barWidth: 6,
      curveSmoothness: .5,
      color: Colors.grey,
      belowBarData: BarAreaData(show: true),
    );

    List<ShowingTooltipIndicators> showingTooltipIndicators = [];
    for (final spot in spots) {
      showingTooltipIndicators.add(
        ShowingTooltipIndicators([
          LineBarSpot(lineBarData, 0, spot),
        ]),
      );
    }

    return SingleChildScrollView(
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
                tooltipMargin: -30,
                getTooltipItems: (List<LineBarSpot> spots) {
                  List<LineTooltipItem> tooltip = [];
                  for (final spot in spots) {
                    tooltip.add(
                      LineTooltipItem(
                        "${spot.y.round().toString()}°C",
                        const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
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
                  reservedSize: 50,
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
    );
  }
}
