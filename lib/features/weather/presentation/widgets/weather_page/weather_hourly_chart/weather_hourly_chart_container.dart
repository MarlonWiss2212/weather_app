import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_hourly_entity.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';
import 'package:weather_app/core/util/enums/hourly_chart_type_enum.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page/weather_hourly_chart/weather_hourly_chart_diagram.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page/weather_hourly_chart/weather_hourly_chart_type_button.dart';

class WeatherHourlyChartContainer extends StatefulWidget {
  const WeatherHourlyChartContainer({super.key});

  @override
  State<WeatherHourlyChartContainer> createState() =>
      _WeatherHourlyChartContainerState();
}

class _WeatherHourlyChartContainerState
    extends State<WeatherHourlyChartContainer> {
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

    final hourlyOrMockData = _generateMockDataWhenRequiredOrReturnHourly(
      hourly,
    );

    return Container(
      height: 250,
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
                  children: _generateHourlyChartTypeButtons(hourlyOrMockData),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Expanded(
              child: WeatherHourlyChartDiagram(
                showSkeleton: showSkeleton,
                diagram: type.getDiagram(hourlyOrMockData),
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
        ? hourly.length > 25
            ? hourly.getRange(0, 25).toList()
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
          pop: 0.5 + i / 100,
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
        WeatherHourlyChartTypeButton(
          type: hourlyChartType,
          currentType: type,
          changeType: () => setState(() => type = hourlyChartType),
        ),
      );
    }
    return childrenHourlyChartTypeButtons;
  }
}
