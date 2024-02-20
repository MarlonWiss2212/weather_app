import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class WeatherMap extends StatelessWidget {
  final List<TileLayer> tiles;
  final LatLng latLng;
  const WeatherMap({
    super.key,
    required this.latLng,
    required this.tiles,
  });

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
        ...tiles,
      ],
    );
  }
}
