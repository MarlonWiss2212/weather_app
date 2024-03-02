import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:skeletonizer/skeletonizer.dart';

class WeatherWind extends StatelessWidget {
  final bool loading;
  final int? windDeg;
  final double? windSpeed;
  const WeatherWind({
    super.key,
    required this.loading,
    this.windDeg,
    this.windSpeed,
  });

  @override
  Widget build(BuildContext context) {
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
                ).animate().fadeIn(),
                const SizedBox(width: 2),
                Transform.rotate(
                  angle: (windDeg ?? 0 - 90) * (pi / 180),
                  child: const Icon(
                    Icons.keyboard_arrow_up_rounded,
                    size: 20,
                  ).animate().fadeIn(),
                ),
                const SizedBox(width: 5),
                Text(
                  "Wind",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
            Text(
              "${windSpeed?.toString() ?? 0} m/s",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
