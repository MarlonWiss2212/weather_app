import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/features/weather/presentation/widgets/general/weather_icon.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page/weather_hourly_chart/hourly_diagram/weather_hourly_diagram.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page/weather_hourly_chart/hourly_diagram/weather_hourly_uvi_diagram.dart';

class WeatherHourlyChartDiagram extends StatelessWidget {
  final WeatherHourlyDiagram diagram;
  final bool showSkeleton;

  const WeatherHourlyChartDiagram({
    super.key,
    required this.diagram,
    required this.showSkeleton,
  });

  LineChartBarData _generateLineChartBarData({required List<FlSpot> spots}) {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      dotData: const FlDotData(show: false),
      barWidth: 5,
      curveSmoothness: .5,
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: diagram.getGradientColors(),
      ),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: diagram.getBelowGradientColors(),
        ),
      ),
    );
  }

  List<ShowingTooltipIndicators> _generateTooltipsList({
    required LineChartBarData lineChartBarData,
    required List<FlSpot> spots,
  }) {
    final List<ShowingTooltipIndicators> tooltips = [];

    for (final spot in spots) {
      tooltips.add(
        ShowingTooltipIndicators([
          LineBarSpot(lineChartBarData, 0, spot),
        ]),
      );
    }

    return tooltips;
  }

  Widget _generateChart(
    BuildContext context, {
    required List<ShowingTooltipIndicators> showingTooltipIndicators,
    required LineChartBarData lineChartBarData,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 1500,
          child: LineChart(
            LineChartData(
              backgroundColor: Colors.transparent,
              showingTooltipIndicators: showingTooltipIndicators,
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  tooltipBgColor: Colors.transparent,
                  tooltipPadding: const EdgeInsets.all(0),
                  tooltipMargin: 7,
                  getTooltipItems: (spots) => diagram.getTooltipItems(
                    context,
                    spots,
                  ),
                ),
                enabled: true,
                handleBuiltInTouches: false,
              ),
              maxX: diagram.maxIndex,
              minX: diagram.minIndex,
              maxY: diagram is WeatherHourlyUviDiagram?
                  ? diagram.maxY > 4
                      ? diagram.maxY
                      : 4
                  : diagram.maxY,
              minY: diagram.minY,
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                show: true,
                topTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 130,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      final hourly = diagram.hourly[value.toInt()];
                      final formattedDate = DateFormat.Hm("de").format(
                        DateTime.fromMillisecondsSinceEpoch(hourly.dt * 1000),
                      );

                      return Column(
                        children: [
                          Text(
                            formattedDate,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          if (hourly.weather.isNotEmpty) ...{
                            WeatherIcon(
                              size: 35,
                              snow: hourly.temp < 0,
                              iconCode: hourly.weather[0].icon,
                            ),
                          },
                          if (hourly.pop > 0 || showSkeleton) ...[
                            const SizedBox(height: 1),
                            _precipitationRow(
                              context,
                              pop: hourly.pop,
                              temp: hourly.temp,
                            ),
                          ],
                        ],
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
              lineBarsData: [lineChartBarData],
            ),
          ),
        ),
      ),
    );
  }

  Widget _precipitationRow(
    BuildContext context, {
    required double temp,
    required double pop,
  }) {
    return Row(
      children: [
        Icon(
          temp > 0 ? Icons.water_drop_rounded : Icons.snowing,
          fill: pop,
          size: 8,
        ),
        const SizedBox(width: 5),
        Text(
          "${(pop * 100).round().toString()}%",
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final spots = diagram.generateSpotsList();
    final LineChartBarData lineChartBarData = _generateLineChartBarData(
      spots: spots,
    );
    final List<ShowingTooltipIndicators> showingTooltipIndicators =
        _generateTooltipsList(
      lineChartBarData: lineChartBarData,
      spots: spots,
    );

    return _generateChart(
      context,
      showingTooltipIndicators: showingTooltipIndicators,
      lineChartBarData: lineChartBarData,
    );
  }
}
