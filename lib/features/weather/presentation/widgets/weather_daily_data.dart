import 'package:flutter/material.dart';

class WeatherDailyData extends StatelessWidget {
  const WeatherDailyData({super.key});

  @override
  Widget build(BuildContext context) {
    // final provider = context.watch<WeatherProvider>();

    return Container(
      height: 200,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text("Daily"),
    );
  }
}
