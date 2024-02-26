import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/presentation/widgets/general/failure_listener.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_map/weather_map_fullscreen_box.dart';

class WeatherMapPage extends StatelessWidget {
  const WeatherMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        title: const Text("Wetter Karte"),
      ),
      body: const FailureListener(child: WeatherMapFullscreenBox()),
    );
  }
}
