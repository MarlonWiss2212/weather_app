import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/util/temp_utils.dart';
import 'package:weather_app/core/util/uv_utils.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_hourly_entity.dart';
import 'package:weather_app/core/util/enums/hourly_chart_type_enum.dart';

class WeatherHourlyChartDiagram extends StatefulWidget {
  final List<WeatherForecastHourlyEntity> hourly;
  final HourlyChartType type;

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

  void _setStandardValues() {
    final double unixDate = widget.hourly[0].dt * 1000;
    _minUnixDate = unixDate;
    _maxUnixDate = unixDate;

    switch (widget.type) {
      case HourlyChartType.temp:
        _minY = double.infinity;
        _maxY = double.negativeInfinity;
        break;
      case HourlyChartType.rain || HourlyChartType.snow:
        _minY = 0;
        _maxY = 15;
        break;
      case HourlyChartType.clouds:
        _minY = 0;
        _maxY = 100;
        break;
      case HourlyChartType.wind:
        _minY = 0;
        _maxY = 30;
        break;
      case HourlyChartType.uvi:
        _minY = 0;
        _maxY = 0;
        break;
    }
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
        case HourlyChartType.temp:
          // Y is equal to lowest and max temp
          if (_maxY < hour.temp) {
            _maxY = hour.temp;
          }
          if (_minY > hour.temp) {
            _minY = hour.temp;
          }

          spots.add(FlSpot(unixDate, hour.temp));
          break;
        case HourlyChartType.clouds:
          // Y is equal to lowest and max temp
          if (_maxY < hour.clouds) {
            _maxY = hour.clouds.toDouble();
          }
          if (_minY > hour.clouds) {
            _minY = hour.clouds.toDouble();
          }
          spots.add(FlSpot(unixDate, hour.clouds.toDouble()));
          break;
        case HourlyChartType.rain:
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
        case HourlyChartType.snow:
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

        case HourlyChartType.wind:
          // Y is equal to lowest and max temp
          if (_maxY < hour.windSpeed) {
            _maxY = hour.windSpeed;
          }
          if (_minY > hour.windSpeed) {
            _minY = hour.windSpeed;
          }
          spots.add(FlSpot(unixDate, hour.windSpeed));
          break;
        case HourlyChartType.uvi:
          // Y is equal to lowest and max temp
          if (_maxY < hour.uvi) {
            _maxY = hour.uvi;
          }
          if (_minY > hour.uvi) {
            _minY = hour.uvi;
          }
          spots.add(FlSpot(unixDate, hour.uvi));
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
          HourlyChartType.temp => [
              TempUtils.colorByTemperatureLight(
                _maxY < 14 ? _maxY - 3 : _maxY + 3,
              ),
              TempUtils.colorByTemperatureLight(
                _minY < 14 ? _minY - 3 : _minY + 3,
              ),
            ],
          HourlyChartType.clouds || HourlyChartType.wind => [
              const Color.fromARGB(255, 163, 163, 163),
              const Color.fromARGB(255, 163, 163, 163),
            ],
          HourlyChartType.uvi => [
              UvUtils.colorByUvIndex(_maxY + 1),
              UvUtils.colorByUvIndex(_minY + 1),
            ],
          HourlyChartType.rain => [
              const Color.fromARGB(255, 0, 81, 202),
              const Color.fromARGB(255, 0, 81, 202),
            ],
          HourlyChartType.snow => [
              const Color.fromARGB(255, 112, 212, 230),
              const Color.fromARGB(255, 112, 212, 230),
            ]
        },
      ),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: switch (widget.type) {
            HourlyChartType.temp => [
                TempUtils.colorByTemperatureLight(_maxY),
                TempUtils.colorByTemperatureLight(_minY),
              ],
            HourlyChartType.clouds || HourlyChartType.wind => [
                const Color.fromARGB(255, 179, 179, 179),
                const Color.fromARGB(255, 179, 179, 179),
              ],
            HourlyChartType.rain => [
                const Color.fromARGB(255, 0, 102, 255),
                const Color.fromARGB(255, 0, 102, 255),
              ],
            HourlyChartType.snow => [
                const Color.fromARGB(255, 153, 240, 255),
                const Color.fromARGB(255, 153, 240, 255),
              ],
            HourlyChartType.uvi => [
                UvUtils.colorByUvIndex(_maxY),
                UvUtils.colorByUvIndex(_minY),
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
                  getTooltipItems: (List<LineBarSpot> spots) {
                    List<LineTooltipItem> tooltips = [];
                    for (final spot in spots) {
                      String sign = switch (widget.type) {
                        HourlyChartType.temp => "°C",
                        HourlyChartType.clouds => "%",
                        HourlyChartType.rain ||
                        HourlyChartType.snow =>
                          "\nmm/h",
                        HourlyChartType.wind => "\nm/s",
                        HourlyChartType.uvi => "\n${UvUtils.uvIndex(spot.y)}",
                      };
                      String number = switch (widget.type) {
                        HourlyChartType.temp ||
                        HourlyChartType.clouds =>
                          spot.y.round().toString(),
                        HourlyChartType.rain ||
                        HourlyChartType.snow ||
                        HourlyChartType.wind ||
                        HourlyChartType.uvi =>
                          spot.y.toString(),
                      };
                      tooltips.add(
                        LineTooltipItem(
                          "$number $sign",
                          Theme.of(context).textTheme.labelLarge ??
                              const TextStyle(),
                        ),
                      );
                    }
                    return tooltips;
                  },
                ),
                enabled: true,
                handleBuiltInTouches: false,
              ),
              maxX: _maxUnixDate,
              maxY: widget.type == HourlyChartType.uvi
                  ? _maxY > 4
                      ? _maxY
                      : 4
                  : _maxY,
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
                    interval: 3600000, // 1 hour == 3600000 milliseconds
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
    _setStandardValues();

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
