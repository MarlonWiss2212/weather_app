import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/core/util/uv_utils.dart';

class WeatherUVIndex extends StatelessWidget {
  final double? uvIndex;
  final bool loading;
  const WeatherUVIndex({
    super.key,
    required this.loading,
    this.uvIndex,
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
        enabled: uvIndex == null && loading,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.sunny,
                  size: 20,
                ).animate().fadeIn(),
                const SizedBox(width: 5),
                Text(
                  "UV Index",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
            Text(
              uvIndex != null ? UvUtils.uvIndex(uvIndex!) : "Unbekannt",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
