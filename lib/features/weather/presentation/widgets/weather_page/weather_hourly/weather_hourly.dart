import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/core/util/temp_utils.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_hourly_entity.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';
import 'package:weather_app/features/weather/presentation/widgets/general/weather_icon.dart';

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
      height: 130,
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
            key: hourly != null
                ? ObjectKey(hourly[index])
                : Key(index.toString()),
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
              Column(
                children: [
                  if (hourly?[index].weather[0] != null) ...{
                    WeatherIcon(
                      size: 35,
                      snow: hourly![index].temp < 0,
                      iconCode: hourly[index].weather[0].icon,
                    ),
                  },
                  if ((hourly?[index] != null && hourly![index].pop > 0) ||
                      showSkeleton) ...[
                    const SizedBox(height: 1),
                    _precipitationRow(
                      context,
                      pop: hourly?[index].pop ?? 0,
                      temp: hourly?[index].temp ?? 10,
                    ),
                  ],
                ],
              ),
              // temp
              Text(
                "${hourly?[index].temp.round()}°C",
                style: Theme.of(context).textTheme.labelLarge,
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

  Widget _precipitationRow(
    BuildContext context, {
    required double pop,
    required double temp,
  }) {
    final color = TempUtils.colorForPrecipitationByTemp(temp);
    return Row(
      children: [
        Icon(
          temp > 0 ? Icons.water_drop_rounded : Icons.snowing,
          fill: pop,
          size: 8,
          color: color,
        ),
        const SizedBox(width: 5),
        Text(
          "${(pop * 100).round().toString()}%",
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: color,
              ),
        ),
      ],
    );
  }
}
