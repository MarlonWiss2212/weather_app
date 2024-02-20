import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/features/weather/domain/entities/geocoding/reverse_geocoding_entity.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_map/weather_map.dart';

class WeatherMapBox extends StatelessWidget {
  const WeatherMapBox({super.key});

  @override
  Widget build(BuildContext context) {
    final geodata = context.select<WeatherProvider, ReverseGeocodingEntity?>(
      (provider) => provider.geodata,
    );
    final loading = context.select<WeatherProvider, bool>(
      (provider) => provider.loading,
    );

    return AspectRatio(
      aspectRatio: 1 / 1,
      child: Skeletonizer(
        enabled: loading && geodata == null,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: geodata != null
              ? WeatherMap(
                  latLng: LatLng(
                    geodata.lat,
                    geodata.lon,
                  ),
                )
              : DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
        ),
      ),
    );
  }
}
