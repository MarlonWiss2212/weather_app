import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/core/util/uv_utils.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';

class WeatherUVIndex extends StatelessWidget {
  const WeatherUVIndex({super.key});

  @override
  Widget build(BuildContext context) {
    final uvIndex = context.select<WeatherProvider, double?>(
      (provider) => provider.weather?.current.uvi,
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
        enabled: uvIndex == null && loading,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.sunny,
                  size: 16,
                ),
                const SizedBox(width: 5),
                Text(
                  "UV Index",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
            Text(
              uvIndex != null ? UvUtils.uvIndex(uvIndex) : "Unbekannt",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
