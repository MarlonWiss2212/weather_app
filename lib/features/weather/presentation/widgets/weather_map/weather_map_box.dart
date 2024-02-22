import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/features/weather/domain/entities/geocoding/reverse_geocoding_entity.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_map/weather_map_stack.dart';

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
          child: WeatherMapStack(
            geodata: geodata,
            weatherMapClickable: true,
          ),
        ),
      ),
    );
  }
}
