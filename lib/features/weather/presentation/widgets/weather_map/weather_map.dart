import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class WeatherMap extends StatelessWidget {
  final LatLng latLng;
  const WeatherMap({super.key, required this.latLng});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.none,
        ),
        initialZoom: 5.5,
        initialCenter: latLng,
      ),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
        ),
        TileLayer(
          urlTemplate:
              "https://tile.openweathermap.org/map/temp_new/{z}/{x}/{y}.png?appid=${dotenv.get("OPEN_WEATHER_APP_ID")}",
        ),
      ],
    );
  }
}
