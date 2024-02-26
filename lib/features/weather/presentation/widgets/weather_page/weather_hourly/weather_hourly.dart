import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_hourly_entity.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page/weather_icon.dart';

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
      height: 180,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Skeletonizer(
        enabled: showSkeleton,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) => Column(
            key: Key(index.toString()),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // date
              Text(
                hourly != null
                    ? DateFormat.Hm("de").format(
                        DateTime.fromMillisecondsSinceEpoch(
                          hourly[index].dt * 1000,
                        ),
                      )
                    : "no hour",
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const WeatherIcon(),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //rain widget
                  if (hourly?[index] != null || showSkeleton) ...[
                    _rainRow(context, hourly?[index]),
                    const SizedBox(height: 5),
                    _cloudsRow(context, hourly?[index]),
                  ],
                  const SizedBox(height: 10),
                  // temp
                  Text(
                    "${hourly?[index].temp.round()}°C",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),
            ],
          ),
          itemCount: hourly != null
              ? hourly.length > 24
                  ? 24
                  : hourly.length
              : 24,
          separatorBuilder: (_, __) => const SizedBox(width: 20),
        ),
      ),
    );
  }

  Widget _cloudsRow(BuildContext context, WeatherForecastHourlyEntity? hour) {
    return Row(
      children: [
        Icon(
          Icons.cloud,
          fill: ((hour?.clouds.toDouble() ?? 0) / 100),
          size: 8,
        ),
        const SizedBox(width: 5),
        Text(
          "${hour?.clouds.toString() ?? "0"}%",
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _rainRow(BuildContext context, WeatherForecastHourlyEntity? hour) {
    return Row(
      children: [
        Icon(
          Icons.water_drop_rounded,
          fill: hour?.pop ?? 0,
          size: 8,
        ),
        const SizedBox(width: 5),
        Text(
          "${((hour?.pop ?? 0) * 100).round().toString()}%",
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
