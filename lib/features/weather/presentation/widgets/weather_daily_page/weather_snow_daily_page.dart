import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WeatherSnowDailyPage extends StatelessWidget {
  final double snow;
  const WeatherSnowDailyPage({
    super.key,
    required this.snow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.snowing,
                size: 20,
              ).animate().fadeIn(),
              const SizedBox(width: 5),
              Text(
                "Schnee",
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
          Text(
            "${snow.toString()} mm",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
