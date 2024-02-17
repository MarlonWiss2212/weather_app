import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/util/temp_utils.dart';
import 'package:weather_app/core/util/uv_utils.dart';
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
  late double _maxYHeight;
  late double _maxYForColor;
  late double _minUnixDate;
  late double _minY;

  void _setStandardValues() {
    final double unixDate = widget.hourly[0].dt * 1000;
    _minUnixDate = unixDate;
    _maxUnixDate = unixDate;

    switch (widget.type) {
      case ChartType.temp:
        _minY = double.infinity;
        _maxYForColor = double.negativeInfinity;
        _maxYHeight = double.negativeInfinity;
        break;
      case ChartType.rain || ChartType.snow:
        _minY = 0;
        _maxYForColor = 15;
        _maxYHeight = 15;
        break;
      case ChartType.clouds:
        _minY = 0;
        _maxYForColor = 100;
        _maxYHeight = 100;
        break;
      case ChartType.wind:
        _minY = 0;
        _maxYForColor = 30;
        _maxYHeight = 30;
        break;
      case ChartType.uvi:
        _minY = 0;
        _maxYForColor = 0;
        _maxYHeight = 4;
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
        case ChartType.temp:
          // Y is equal to lowest and max temp
          if (_maxYForColor < hour.temp) {
            _maxYForColor = hour.temp;
          }
          if (_maxYHeight < hour.temp) {
            _maxYHeight = hour.temp;
          }
          if (_minY > hour.temp) {
            _minY = hour.temp;
          }

          spots.add(FlSpot(unixDate, hour.temp));
          break;
        case ChartType.clouds:
          // Y is equal to lowest and max temp
          if (_maxYForColor < hour.clouds) {
            _maxYForColor = hour.clouds.toDouble();
          }
          if (_maxYHeight < hour.clouds) {
            _maxYHeight = hour.clouds.toDouble();
          }
          if (_minY > hour.clouds) {
            _minY = hour.clouds.toDouble();
          }
          spots.add(FlSpot(unixDate, hour.clouds.toDouble()));
          break;
        case ChartType.rain:
          // Y is equal to lowest and max temp
          final rainOneHour = hour.rain?.oneHour ?? 0.0;
          if (_maxYForColor < rainOneHour) {
            _maxYForColor = rainOneHour;
          }
          if (_maxYHeight < rainOneHour) {
            _maxYHeight = rainOneHour;
          }
          if (_minY > rainOneHour) {
            _minY = rainOneHour;
          }
          spots.add(FlSpot(unixDate, rainOneHour));
          break;
        case ChartType.snow:
          // Y is equal to lowest and max temp
          final snowOneHour = hour.snow?.oneHour ?? 0.0;
          if (_maxYForColor < snowOneHour) {
            _maxYForColor = snowOneHour;
          }
          if (_maxYHeight < snowOneHour) {
            _maxYHeight = snowOneHour;
          }
          if (_minY > snowOneHour) {
            _minY = snowOneHour;
          }
          spots.add(FlSpot(unixDate, snowOneHour));
          break;
        case ChartType.wind:
          // Y is equal to lowest and max temp
          if (_maxYForColor < hour.windSpeed) {
            _maxYForColor = hour.windSpeed;
          }
          if (_maxYHeight < hour.windSpeed) {
            _maxYHeight = hour.windSpeed;
          }
          if (_minY > hour.windSpeed) {
            _minY = hour.windSpeed;
          }
          spots.add(FlSpot(unixDate, hour.windSpeed));
          break;
        case ChartType.uvi:
          // Y is equal to lowest and max temp
          if (_maxYForColor < hour.uvi) {
            _maxYForColor = hour.uvi;
          }
          if (_maxYHeight < hour.windSpeed) {
            _maxYHeight = hour.windSpeed;
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
          ChartType.temp => [
              TempUtils.colorByTemperatureLight(
                _maxYForColor < 14 ? _maxYForColor - 3 : _maxYForColor + 3,
              ),
              TempUtils.colorByTemperatureLight(
                _minY < 14 ? _minY - 3 : _minY + 3,
              ),
            ],
          ChartType.clouds || ChartType.wind => [
              const Color.fromARGB(255, 163, 163, 163),
              const Color.fromARGB(255, 163, 163, 163),
            ],
          ChartType.uvi => [
              UvUtils.colorByUvIndex(_maxYForColor + 1),
              UvUtils.colorByUvIndex(_minY + 1),
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
                TempUtils.colorByTemperatureLight(_maxYForColor),
                TempUtils.colorByTemperatureLight(_minY),
              ],
            ChartType.clouds || ChartType.wind => [
                const Color.fromARGB(255, 179, 179, 179),
                const Color.fromARGB(255, 179, 179, 179),
              ],
            ChartType.rain => [
                const Color.fromARGB(255, 0, 102, 255),
                const Color.fromARGB(255, 0, 102, 255),
              ],
            ChartType.uvi => [
                UvUtils.colorByUvIndex(_maxYForColor),
                UvUtils.colorByUvIndex(_minY),
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
                    List<LineTooltipItem> tooltips = [];
                    for (final spot in spots) {
                      String sign = switch (widget.type) {
                        ChartType.temp => "°C",
                        ChartType.clouds => "%",
                        ChartType.rain || ChartType.snow => "mm/h",
                        ChartType.wind => "m/s",
                        ChartType.uvi => "\n${UvUtils.uvIndex(spot.y)}",
                      };
                      String number = switch (widget.type) {
                        ChartType.temp => spot.y.round().toString(),
                        ChartType.clouds => spot.y.round().toString(),
                        ChartType.rain || ChartType.snow => spot.y.toString(),
                        ChartType.wind => spot.y.toString(),
                        ChartType.uvi => spot.y.toString(),
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
              maxY: _maxYHeight,
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
