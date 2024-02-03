import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_hourly_entity.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_hourly/weather_hourly_change_diagram_button.dart';

class WeatherHourly extends StatefulWidget {
  const WeatherHourly({super.key});

  @override
  State<WeatherHourly> createState() => _WeatherHourlyState();
}

class _WeatherHourlyState extends State<WeatherHourly> {
  bool rainDiagram = true;

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
      height: 250,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Skeletonizer(
        enabled: showSkeleton,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Flexible(
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
              const Divider(),
              WeatherHourlyChangeDiagramButton(
                onChanged: (newValue) => setState(() => rainDiagram),
                value: rainDiagram,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
