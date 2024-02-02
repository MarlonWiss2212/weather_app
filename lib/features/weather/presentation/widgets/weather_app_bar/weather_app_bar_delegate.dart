import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';
import 'package:intl/intl.dart';

class WeatherAppBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final provider = context.watch<WeatherProvider>();
    final progress = minExtent / shrinkOffset;

    return SizedBox.expand(
      child: Container(
        color: Theme.of(context).colorScheme.background,
        padding: const EdgeInsets.all(8.0),
        child: Skeletonizer(
          enabled: provider.loading && provider.weather == null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                provider.weather != null
                    ? "${provider.weather!.current.temp.round()}°"
                    : "Temp",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: max(
                    30,
                    min(progress * 30, 44),
                  ),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    provider.weather != null
                        ? "${provider.weather!.lat}"
                        : "City",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: max(
                        26,
                        min(progress * 26, 40),
                      ),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
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
                        min(progress * 16, 24),
                      ),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 250;

  @override
  double get minExtent => 120;

  @override
  bool shouldRebuild(oldDelegate) => true;
}
