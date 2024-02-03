import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_hourly_entity.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';

class WeatherHourly extends StatelessWidget {
  const WeatherHourly({super.key});

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
      height: 200,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Skeletonizer(
        enabled: showSkeleton,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
        ),
      ),
    );
  }
}
