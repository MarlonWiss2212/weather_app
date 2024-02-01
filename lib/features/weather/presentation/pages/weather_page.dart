import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_app_bar/weather_app_bar_temp.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: CustomScrollView(
          slivers: [
            WeatherAppBarTemp(),
          ],
        ),
      ),
    );
  }
}
