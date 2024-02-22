import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_map/weather_map_fullscreen_box.dart';

class WeatherMapPage extends StatelessWidget {
  const WeatherMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 12, 158, 226),
        title: const Text("Wetter Karte"),
      ),
      body: const WeatherMapFullscreenBox(),
    );
  }
}
