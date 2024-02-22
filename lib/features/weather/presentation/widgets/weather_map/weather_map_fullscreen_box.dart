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
import 'package:weather_app/features/weather/presentation/widgets/weather_map/weather_map_type_button.dart';

class WeatherMapFullscreenBox extends StatefulWidget {
  const WeatherMapFullscreenBox({super.key});

  @override
  State<WeatherMapFullscreenBox> createState() =>
      _WeatherMapFullscreenBoxState();
}

class _WeatherMapFullscreenBoxState extends State<WeatherMapFullscreenBox> {
  MapType type = MapType.temp;

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
                    (index) => WeatherMapTypeButton(
                      type: MapType.values[index],
                      activeType: type,
                      onTap: () => setState(
                        () => type = MapType.values[index],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
