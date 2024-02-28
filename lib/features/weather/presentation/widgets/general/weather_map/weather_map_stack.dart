import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/util/enums/map_type_enum.dart';
import 'package:weather_app/features/weather/domain/entities/geocoding/reverse_geocoding_entity.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';
import 'package:weather_app/features/weather/presentation/widgets/general/weather_map/weather_map.dart';
import 'package:weather_app/features/weather/presentation/widgets/general/weather_map/weather_map_type_button.dart';

class WeatherMapStack extends StatelessWidget {
  final ReverseGeocodingEntity? geodata;
  final BorderRadius? borderRadius;
  final bool weatherMapClickable;
  const WeatherMapStack({
    super.key,
    this.borderRadius,
    this.geodata,
    this.weatherMapClickable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        geodata != null
            ? WeatherMap(
                latLng: LatLng(
                  geodata!.lat,
                  geodata!.lon,
                ),
              )
            : DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.15),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: borderRadius,
            onTap: weatherMapClickable ? () => context.push("/map") : null,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0, .4],
                  colors: [Colors.black.withOpacity(.4), Colors.transparent],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  MapType.values.length,
                  (index) => WeatherMapTypeButton(
                    type: MapType.values[index],
                    onTap: () => Provider.of<WeatherProvider>(
                      context,
                      listen: false,
                    ).setActiveMapType(MapType.values[index]),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
