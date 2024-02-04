import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_hourly_entity.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_hourly_rain/weather_hourly_rain_chart.dart';

class WeatherHourlyRain extends StatelessWidget {
  const WeatherHourlyRain({super.key});

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

    final List<WeatherForecastHourlyEntity> data = hourly ?? [];

    if (hourly == null) {
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

    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Skeletonizer(
        enabled: showSkeleton,
        child: WeatherHourlyRainChart(hourly: data),
      ),
    );
  }
}
/**Flexible(
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Skeletonizer(
                    enabled: loading && hourly == null,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${hourly?[index].temp.round()}°C",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Column(
                          children: [
                            if (hourly?[index].rain?.oneHour != null ||
                                showSkeleton) ...{
                              Row(
                                children: [
                                  Icon(
                                    Icons.water_drop,
                                    fill: hourly?[index].pop ?? 1,
                                    size: 14,
                                  ),
                                  Text(
                                    "${((hourly?[index].pop ?? 1) * 100).round().toString()}%",
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            },
                            const SizedBox(height: 10),
                            Text(
                              hourly != null
                                  ? DateFormat.Hm("de").format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                        hourly[index].dt * 1000,
                                      ),
                                    )
                                  : "no hour",
                              style: const TextStyle(fontSize: 13),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  itemCount: hourly != null
                      ? hourly.length > 24
                          ? 24
                          : hourly.length
                      : 10,
                  separatorBuilder: (_, __) => const SizedBox(width: 20),
                ),
              ), */
