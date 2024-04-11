import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/features/weather/presentation/widgets/general/weather_app_bar/weather_app_bar_base_delegate.dart';

class WeatherAppBarDelegate extends WeatherAppBarBaseDelegate {
  @override
  Widget child(BuildContext context, double progress) {
    final provider = context.watch<WeatherProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Skeletonizer(
          enabled: provider.loading && provider.weather == null,
          child: Text(
            provider.weather != null
                ? "${provider.weather!.current.temp.round()}°"
                : "Temp",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: max(
                30,
                min(progress * 24, 44),
              ),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Skeletonizer(
              enabled: provider.loading && provider.geodata == null,
              child: Text(
                provider.geodata != null ? provider.geodata!.name : "City",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: max(
                    20,
                    min(progress * 17, 30),
                  ),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Skeletonizer(
              enabled: provider.loading && provider.weather == null,
              child: Text(
                provider.weather != null
                    ? DateFormat.yMd("de")
                        .format(DateTime.fromMillisecondsSinceEpoch(
                          provider.weather!.current.dt * 1000,
                        ))
                        .toString()
                    : "Date",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: max(
                    16,
                    min(progress * 14, 20),
                  ),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
