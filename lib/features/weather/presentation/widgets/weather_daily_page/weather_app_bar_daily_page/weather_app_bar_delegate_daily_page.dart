import 'dart:math';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_daily_entity.dart';
import 'package:weather_app/features/weather/presentation/widgets/general/weather_app_bar/weather_app_bar_base_delegate.dart';

class WeatherAppBarDelegateDailyPage extends WeatherAppBarBaseDelegate {
  final WeatherForecastDailyEntity? day;
  final bool loading;
  WeatherAppBarDelegateDailyPage({
    required this.loading,
    this.day,
  });

  Widget _weekdayTextWidget(BuildContext context, double progress) => Text(
        day?.weekday ?? "Date",
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.tertiary,
              fontSize: max(
                20,
                min(progress * 16, 28),
              ),
              fontWeight: FontWeight.bold,
            ),
      );

  @override
  Widget child(BuildContext context, double progress) {
    return Column(
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
    );
  }
}
