import 'dart:math';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_daily_entity.dart';

class WeatherAppBarDelegateDailyPage extends SliverPersistentHeaderDelegate {
  final bool loading;
  final WeatherForecastDailyEntity? day;
  WeatherAppBarDelegateDailyPage({
    required this.loading,
    this.day,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final progress = minExtent / shrinkOffset;
    return SizedBox.expand(
      child: Container(
        color: const Color.fromARGB(255, 12, 158, 226),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Skeletonizer(
              enabled: loading && day == null,
              child: Hero(
                tag: "DailyTemp${day?.dt}",
                child: Text(
                  day != null
                      ? "${day!.temp.day.round()}°C / ${day!.temp.night.round()}°C"
                      : "Temp",
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: max(
                          30,
                          min(progress * 30, 44),
                        ),
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
            Skeletonizer(
              enabled: loading && day == null,
              child: day != null
                  ? Hero(
                      tag: day!.weekday + day!.dt.toString(),
                      child: _weekdayTextWidget(context, progress),
                    )
                  : _weekdayTextWidget(context, progress),
            ),
          ],
        ),
      ),
    );
  }

  Widget _weekdayTextWidget(BuildContext context, double progress) => Text(
        day?.weekday ?? "Date",
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.tertiary,
              fontSize: max(
                20,
                min(progress * 24, 28),
              ),
              fontWeight: FontWeight.bold,
            ),
      );

  @override
  double get maxExtent => 230;

  @override
  double get minExtent => 90;

  @override
  bool shouldRebuild(oldDelegate) => true;
}
