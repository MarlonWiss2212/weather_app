import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';

class WeatherWind extends StatelessWidget {
  const WeatherWind({super.key});

  @override
  Widget build(BuildContext context) {
    final windSpeed = context.select<WeatherProvider, double?>(
      (provider) => provider.weather?.current.windSpeed,
    );
    final windDeg = context.select<WeatherProvider, int?>(
      (provider) => provider.weather?.current.windDeg,
    );
    final loading = context.select<WeatherProvider, bool>(
      (provider) => provider.loading,
    );

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Skeletonizer(
        enabled: (windSpeed == null || windDeg == null) && loading,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.air,
                  size: 20,
                ),
                const SizedBox(width: 2),
                Transform.rotate(
                  angle: (windDeg ?? 0 - 90) * (pi / 180),
                  child: const Icon(
                    Icons.keyboard_arrow_left_rounded,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  "Wind",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
            Text(
              "${windSpeed?.round().toString() ?? 0} m/s",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
