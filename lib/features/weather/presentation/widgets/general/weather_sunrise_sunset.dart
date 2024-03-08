import 'package:arc_progress_bar_new/arc_progress_bar_new.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class WeatherSunriseSunset extends StatelessWidget {
  final bool loading;
  final int? sunrise;
  final int? sunset;
  final double? percentage;
  const WeatherSunriseSunset({
    super.key,
    required this.loading,
    this.percentage,
    this.sunrise,
    this.sunset,
  });

  double _getProgressPercentage() {
    if (sunrise == null || sunset == null) {
      return 0;
    }
    final int minimum = sunrise!;
    final int maximum = sunset!;
    final int current = DateTime.now().millisecondsSinceEpoch;
    return ((current - minimum) / (maximum - minimum)) * 100;
  }

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
        child: ArcProgressBar(
          innerPadding: 10,
          percentage: percentage ?? _getProgressPercentage(),
          strokeCap: StrokeCap.round,
          arcThickness: 5,
          handleSize: 30,
          handleWidget: const Icon(
            CupertinoIcons.sun_max_fill,
            color: Colors.yellow,
            size: 30,
          ),
          foregroundColor: Colors.yellow,
          backgroundColor: Theme.of(context).colorScheme.primary,
          bottomLeftWidget: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Column(
              children: [
                Text(
                  "Sonnenaufgang",
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
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
          ),
          bottomRightWidget: Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Column(
              children: [
                Text(
                  "Sonnenuntergang",
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                if (sunrise != null) ...{
                  Text(
                    DateFormat.Hm("de").format(
                      DateTime.fromMillisecondsSinceEpoch(sunset!),
                    ),
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                },
              ],
            ),
          ),
        ),
      ),
    );
  }
}
