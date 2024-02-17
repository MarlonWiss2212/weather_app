import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';

class WeatherHumidity extends StatelessWidget {
  const WeatherHumidity({super.key});

  @override
  Widget build(BuildContext context) {
    final humidity = context.select<WeatherProvider, int?>(
      (provider) => provider.weather?.current.humidity,
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
        enabled: humidity == null && loading,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.water_drop_rounded,
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
