import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class WeatherSunriseSunset extends StatelessWidget {
  final bool loading;
  final int? sunrise;
  final int? sunset;
  const WeatherSunriseSunset({
    super.key,
    required this.loading,
    this.sunrise,
    this.sunset,
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
                      DateTime.fromMillisecondsSinceEpoch(sunrise!),
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
                ).animate().fade().scale(),
                if (sunset != null) ...{
                  Text(
                    DateFormat.Hm("de").format(
                      DateTime.fromMillisecondsSinceEpoch(sunset!),
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
