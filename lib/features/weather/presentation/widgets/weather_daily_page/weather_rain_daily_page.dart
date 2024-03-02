import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';

class WeatherRainDailyPage extends StatelessWidget {
  final double? rain;
  const WeatherRainDailyPage({
    super.key,
    this.rain,
  });

  @override
  Widget build(BuildContext context) {
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
        enabled: rain == null && loading,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.water_drop,
                  size: 20,
                ).animate().fadeIn(),
                const SizedBox(width: 5),
                Text(
                  "Regen",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
            Text(
              "${rain != null ? rain!.toString() : '0'} mm",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
