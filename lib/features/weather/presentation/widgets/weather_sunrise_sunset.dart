import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';

class WeatherSunriseSunset extends StatelessWidget {
  const WeatherSunriseSunset({super.key});

  @override
  Widget build(BuildContext context) {
    final sunrise = context.select<WeatherProvider, int?>(
      (provider) => provider.weather != null
          ? provider.weather!.current.sunrise * 1000
          : null, // * 1000 to make it unix
    );
    final sunset = context.select<WeatherProvider, int?>(
      (provider) => provider.weather != null
          ? provider.weather!.current.sunset * 1000
          : null, // * 1000 to make it unix
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
        enabled: (sunrise == null || sunset == null) && loading,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  "Sonnenaufgang",
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const Icon(
                  CupertinoIcons.sunrise_fill,
                  size: 40,
                ).animate().fade().scale(),
                if (sunrise != null) ...{
                  Text(
                    DateFormat.Hm("de").format(
                      DateTime.fromMillisecondsSinceEpoch(sunrise),
                    ),
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                },
              ],
            ),
            Column(
              children: [
                Text(
                  "Sonnenuntergang",
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const Icon(
                  CupertinoIcons.sunset_fill,
                  size: 40,
                ).animate().fadeIn(),
                if (sunset != null) ...{
                  Text(
                    DateFormat.Hm("de").format(
                      DateTime.fromMillisecondsSinceEpoch(sunset),
                    ),
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                },
              ],
            ),
          ],
        ),
      ),
    );
  }
}
