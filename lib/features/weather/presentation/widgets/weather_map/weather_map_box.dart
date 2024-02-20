import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/core/util/enums/map_type_enum.dart';
import 'package:weather_app/features/weather/domain/entities/geocoding/reverse_geocoding_entity.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_map/weather_map.dart';

class WeatherMapBox extends StatefulWidget {
  const WeatherMapBox({super.key});

  @override
  State<WeatherMapBox> createState() => _WeatherMapBoxState();
}

class _WeatherMapBoxState extends State<WeatherMapBox> {
  MapType type = MapType.temp;

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
          child: Stack(
            fit: StackFit.expand,
            children: [
              geodata != null
                  ? WeatherMap(
                      tiles: [
                        TileLayer(
                          urlTemplate:
                              "https://tile.openweathermap.org/map/${type.weatherMapKey}/{z}/{x}/{y}.png?appid=${dotenv.get("OPEN_WEATHER_APP_ID")}",
                        ),
                      ],
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
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0, .4],
                    colors: [Colors.black.withOpacity(.4), Colors.transparent],
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
                        (index) => _mapTypeButton(
                          MapType.values[index],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mapTypeButton(MapType type) {
    return Container(
      // TODO: better way for margin in future
      margin: const EdgeInsets.only(right: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: () => setState(() => this.type = type),
          child: Container(
            constraints: const BoxConstraints(minWidth: 70),
            decoration: BoxDecoration(
              color: this.type == type
                  ? const Color.fromARGB(100, 0, 0, 0)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.all(6),
            child: Center(
              child: Text(
                type.title,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
