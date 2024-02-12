import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/util/color_utils.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_hourly_entity.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_hourly_chart/chart_type.dart';

class WeatherHourlyChartDiagram extends StatefulWidget {
  final List<WeatherForecastHourlyEntity> hourly;
  final ChartType type;

  const WeatherHourlyChartDiagram({
    super.key,
    required this.hourly,
    required this.type,
  });

  @override
  State<WeatherHourlyChartDiagram> createState() =>
      _WeatherHourlyChartDiagramState();
}

class _WeatherHourlyChartDiagramState extends State<WeatherHourlyChartDiagram> {
  late double _maxUnixDate;
  late double _maxY;
  late double _minUnixDate;
  late double _minY;

  void _setVariablesToStandardValues() {
    final double unixDate = widget.hourly[0].dt * 1000;
    _maxY = unixDate;
    _maxUnixDate = widget.hourly[0].temp == _maxY
        ? widget.hourly[0].temp + 1
        : widget.hourly[0].temp;
    _minUnixDate = unixDate;
    _minY = widget.hourly[0].temp;
  }

  List<FlSpot> _generateSpotsList() {
    List<FlSpot> spots = [];

    for (final hour in widget.hourly) {
      // X is equal to date
      final double unixDate = hour.dt * 1000;
      if (_maxUnixDate < unixDate) {
        _maxUnixDate = unixDate;
      }
      if (_minUnixDate > unixDate) {
        _minUnixDate = unixDate;
      }

      switch (widget.type) {
        case ChartType.temp:
          // Y is equal to lowest and max temp
          if (_maxY < hour.temp) {
            _maxY = hour.temp;
          }
          if (_minY > hour.temp) {
            _minY = hour.temp;
          }

          spots.add(FlSpot(unixDate, hour.temp));
          break;
        case ChartType.clouds:
          // Y is equal to lowest and max temp
          if (_maxY < hour.clouds) {
            _maxY = hour.clouds.toDouble();
          }
          if (_minY > hour.clouds) {
            _minY = hour.clouds.toDouble();
          }
          spots.add(FlSpot(unixDate, hour.clouds.toDouble()));
          break;
        case ChartType.rain:
          // Y is equal to lowest and max temp
          final rainOneHour = hour.rain?.oneHour ?? 0.0;
          if (_maxY < rainOneHour) {
            _maxY = rainOneHour;
          }
          if (_minY > rainOneHour) {
            _minY = rainOneHour;
          }
          spots.add(FlSpot(unixDate, rainOneHour));
          break;
        case ChartType.snow:
          // Y is equal to lowest and max temp
          final snowOneHour = hour.snow?.oneHour ?? 0.0;
          if (_maxY < snowOneHour) {
            _maxY = snowOneHour;
          }
          if (_minY > snowOneHour) {
            _minY = snowOneHour;
          }
          spots.add(FlSpot(unixDate, snowOneHour));
          break;
        case ChartType.wind:
          // Y is equal to lowest and max temp
          if (_maxY < hour.windSpeed) {
            _maxY = hour.windSpeed;
          }
          if (_minY > hour.windSpeed) {
            _minY = hour.windSpeed;
          }
          spots.add(FlSpot(unixDate, hour.windSpeed));
          break;
      }
    }

    return spots;
  }

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
        colors: switch (widget.type) {
          ChartType.temp => [
              ColorUtils.colorByTemperatureLight(
                _maxY < 14 ? _maxY - 3 : _maxY + 3,
              ),
              ColorUtils.colorByTemperatureLight(
                _minY < 14 ? _minY - 3 : _minY + 3,
              ),
            ],
          ChartType.clouds || ChartType.wind => [
              const Color.fromARGB(255, 163, 163, 163),
              const Color.fromARGB(255, 163, 163, 163),
            ],
          ChartType.rain => [
              const Color.fromARGB(255, 0, 81, 202),
              const Color.fromARGB(255, 0, 81, 202),
            ],
          ChartType.snow => [
              const Color.fromARGB(255, 112, 212, 230),
              const Color.fromARGB(255, 112, 212, 230),
            ],
        },
      ),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: switch (widget.type) {
            ChartType.temp => [
                ColorUtils.colorByTemperatureLight(_maxY),
                ColorUtils.colorByTemperatureLight(_minY),
              ],
            ChartType.clouds || ChartType.wind => [
                const Color.fromARGB(255, 179, 179, 179),
                const Color.fromARGB(255, 179, 179, 179),
              ],
            ChartType.rain => [
                const Color.fromARGB(255, 0, 102, 255),
                const Color.fromARGB(255, 0, 102, 255),
              ],
            ChartType.snow => [
                const Color.fromARGB(255, 153, 240, 255),
                const Color.fromARGB(255, 153, 240, 255),
              ],
          },
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

  Widget generateChart({
    required List<ShowingTooltipIndicators> showingTooltipIndicators,
    required LineChartBarData lineChartBarData,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 1800,
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
                      String sign = switch (widget.type) {
                        ChartType.temp => "°C",
                        ChartType.clouds => "%",
                        ChartType.rain || ChartType.snow => "mm/h",
                        ChartType.wind => "m/s",
                      };
                      String number = switch (widget.type) {
                        ChartType.temp => spot.y.round().toString(),
                        ChartType.clouds => spot.y.round().toString(),
                        ChartType.rain || ChartType.snow => spot.y.toString(),
                        ChartType.wind => spot.y.toString(),
                      };
                      tooltip.add(
                        LineTooltipItem(
                          "$number $sign",
                          Theme.of(context).textTheme.labelLarge ??
                              const TextStyle(),
                        ),
                      );
                    }
                    return tooltip;
                  },
                ),
                enabled: true,
                handleBuiltInTouches: false,
              ),
              maxX: _maxUnixDate,
              maxY: _maxY,
              minX: _minUnixDate,
              minY: _minY,
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                show: true,
                topTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 70,
                    interval: 3600000,
                    getTitlesWidget: (value, meta) {
                      final formattedDate = DateFormat.Hm("de").format(
                        DateTime.fromMillisecondsSinceEpoch(value.toInt()),
                      );
                      return Text(
                        formattedDate,
                        style: Theme.of(context).textTheme.labelLarge,
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

  @override
  Widget build(BuildContext context) {
    _setVariablesToStandardValues();

    final List<FlSpot> spots = _generateSpotsList();

    final LineChartBarData lineChartBarData = _generateLineChartBarData(
      spots: spots,
    );

    final List<ShowingTooltipIndicators> showingTooltipIndicators =
        _generateTooltipsList(
      lineChartBarData: lineChartBarData,
      spots: spots,
    );

    return generateChart(
      showingTooltipIndicators: showingTooltipIndicators,
      lineChartBarData: lineChartBarData,
    );
  }
}
