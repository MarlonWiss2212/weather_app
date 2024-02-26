import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_hourly_entity.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';
import 'package:weather_app/core/util/enums/hourly_chart_type_enum.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page/weather_hourly_chart/weather_hourly_chart_diagram.dart';

class WeatherHourlyChart extends StatefulWidget {
  const WeatherHourlyChart({super.key});

  @override
  State<WeatherHourlyChart> createState() => _WeatherHourlyChartState();
}

class _WeatherHourlyChartState extends State<WeatherHourlyChart> {
  HourlyChartType type = HourlyChartType.temp;

  @override
  Widget build(BuildContext context) {
    final hourly =
        context.select<WeatherProvider, List<WeatherForecastHourlyEntity>?>(
      (provider) => provider.weather?.hourly,
    );
    final loading = context.select<WeatherProvider, bool>(
      (provider) => provider.loading,
    );
    final showSkeleton = loading && hourly == null;

    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Skeletonizer(
        enabled: showSkeleton,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: _generateHourlyChartTypeButtons(hourly ?? [])),
              ),
            ),
            const SizedBox(height: 6),
            Expanded(
              child: WeatherHourlyChartDiagram(
                hourly: _generateMockDataWhenRequiredOrReturnHourly(hourly),
                type: type,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<WeatherForecastHourlyEntity> _generateMockDataWhenRequiredOrReturnHourly(
    List<WeatherForecastHourlyEntity>? hourly,
  ) {
    final List<WeatherForecastHourlyEntity> data = hourly != null
        ? hourly.length > 24
            ? hourly.getRange(0, 24).toList()
            : hourly
        : [];

    if (hourly == null || hourly.isEmpty) {
      for (int i = 0; i < 10; i++) {
        data.add(WeatherForecastHourlyEntity(
          dt: 1644060000 + (i * 3600),
          temp: 25.5 + (Random().nextDouble() * 5),
          feelsLike: 26.2 + i,
          pressure: 1012,
          humidity: 75,
          dewPoint: 20.8,
          uvi: 5.8,
          clouds: 30,
          visibility: 10000,
          windSpeed: 4.5,
          windDeg: 180,
          weather: const [],
          pop: 10.0 + i,
        ));
      }
    }
    return data;
  }

  (double, double) _calcMaxRainAndSnowForAllHours(
    List<WeatherForecastHourlyEntity> hourly,
  ) {
    double maxRainHourly = 0;
    double maxSnowHourly = 0;
    for (WeatherForecastHourlyEntity hour in hourly) {
      if (hour.rain?.oneHour != null && hour.rain!.oneHour! > maxRainHourly) {
        maxRainHourly = hour.rain!.oneHour!;
      }
      if (hour.snow?.oneHour != null && hour.snow!.oneHour! > maxSnowHourly) {
        maxSnowHourly = hour.snow!.oneHour!;
      }
    }
    return (maxRainHourly, maxSnowHourly);
  }

  List<Widget> _generateHourlyChartTypeButtons(
    List<WeatherForecastHourlyEntity> hourly,
  ) {
    final (maxRainHourly, maxSnowHourly) = _calcMaxRainAndSnowForAllHours(
      hourly,
    );

    List<Widget> childrenHourlyChartTypeButtons = [];
    for (final hourlyChartType in HourlyChartType.values) {
      // dont show rain diagramm when there is no rain
      if (hourlyChartType == HourlyChartType.rain && maxRainHourly <= 0) {
        continue;
      }

      // dont show snow diagramm when there is no snow
      if (hourlyChartType == HourlyChartType.snow && maxSnowHourly <= 0) {
        continue;
      }

      childrenHourlyChartTypeButtons.add(
        _hourlyChartTypeButton(hourlyChartType),
      );
    }
    return childrenHourlyChartTypeButtons;
  }

  Widget _hourlyChartTypeButton(HourlyChartType type) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: () => setState(() => this.type = type),
        child: Container(
          constraints: const BoxConstraints(minWidth: 70),
          decoration: BoxDecoration(
            color: this.type == type
                ? const Color.fromARGB(100, 0, 0, 0)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          padding: const EdgeInsets.all(6),
          child: Center(
            child: Text(
              type.title,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
      ),
    );
  }
}
