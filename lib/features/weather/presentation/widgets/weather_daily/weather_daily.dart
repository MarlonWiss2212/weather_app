import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_daily_entity.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_daily/weather_daily_container.dart';

class WeatherDaily extends StatelessWidget {
  const WeatherDaily({super.key});

  @override
  Widget build(BuildContext context) {
    final daily =
        context.select<WeatherProvider, List<WeatherForecastDailyEntity>?>(
      (provider) => provider.weather?.daily,
    );
    final loading = context.select<WeatherProvider, bool>(
      (provider) => provider.loading,
    );
    final showSkeleton = loading && daily == null;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Skeletonizer(
        enabled: showSkeleton,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) => WeatherDailyContainer(
            day: daily?[index],
            key: Key(index.toString()),
          ),
          itemCount: daily != null
              ? daily.length > 8
                  ? 8
                  : daily.length
              : 8,
        ),
      ),
    );
  }
}
