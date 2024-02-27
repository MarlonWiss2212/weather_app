import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherHumidity extends StatelessWidget {
  final bool loading;
  final int? humidity;
  const WeatherHumidity({
    super.key,
    required this.loading,
    this.humidity,
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
        enabled: humidity == null && loading,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  WeatherIcons.humidity,
                  size: 20,
                ).animate().fadeIn(),
                const SizedBox(width: 5),
                Text(
                  "Feuchtigkeit",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
            Text(
              "${humidity ?? 0} %",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
