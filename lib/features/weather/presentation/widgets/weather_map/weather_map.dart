import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/util/enums/map_type_enum.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';

class WeatherMap extends StatelessWidget {
  final LatLng latLng;
  final bool clickable;
  const WeatherMap({
    super.key,
    required this.latLng,
    this.clickable = true,
  });

  @override
  Widget build(BuildContext context) {
    final activeType = context.select<WeatherProvider, MapType>(
      (provider) => provider.activeMapType,
    );
    return Hero(
      tag: "map",
      child: FlutterMap(
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
                "https://tile.openweathermap.org/map/${activeType.weatherMapKey}/{z}/{x}/{y}.png?appid=${dotenv.get("OPEN_WEATHER_APP_ID")}",
          ),
        ],
      ),
    );
  }
}
