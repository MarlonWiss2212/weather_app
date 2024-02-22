import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/features/weather/domain/entities/geocoding/reverse_geocoding_entity.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_map/weather_map_stack.dart';

class WeatherMapFullscreenBox extends StatelessWidget {
  const WeatherMapFullscreenBox({super.key});

  @override
  Widget build(BuildContext context) {
    final geodata = context.select<WeatherProvider, ReverseGeocodingEntity?>(
      (provider) => provider.geodata,
    );
    final loading = context.select<WeatherProvider, bool>(
      (provider) => provider.loading,
    );

    return Skeletonizer(
      enabled: loading && geodata == null,
      child: WeatherMapStack(
        geodata: geodata,
        weatherMapClickable: false,
      ),
    );
  }
}
