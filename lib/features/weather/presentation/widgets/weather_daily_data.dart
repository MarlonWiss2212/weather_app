import 'package:flutter/material.dart';

class WeatherDailyData extends StatelessWidget {
  const WeatherDailyData({super.key});

  @override
  Widget build(BuildContext context) {
    // final provider = context.watch<WeatherProvider>();

    return Container(
      height: 100,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text("Daily"),
    );
  }
}
