import 'package:weather_app/core/params/get_weather_params.dart';

class GetWeatherWithLocationParams extends GetWeatherParams {
  /// Latitude, decimal (-90; 90). If you need the geocoder to automatic convert city names and zip-codes to geo coordinates and the other way around, please use our Geocoding API [https://openweathermap.org/api/geocoding-api]
  final double lat;

  /// Longitude, decimal (-180; 180). If you need the geocoder to automatic convert city names and zip-codes to geo coordinates and the other way around, please use our Geocoding API [https://openweathermap.org/api/geocoding-api]
  final double lon;

  const GetWeatherWithLocationParams({
    required this.lat,
    required this.lon,
    required super.appid,
    super.exclude,
    super.lang,
    super.units,
  });

  factory GetWeatherWithLocationParams.fromGetWeatherParams({
    required GetWeatherParams params,
    required double lat,
    required double lon,
  }) {
    return GetWeatherWithLocationParams(
      appid: params.appid,
      lat: lat,
      lon: lon,
      exclude: params.exclude,
      lang: params.lang,
      units: params.units,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      "lat": lat,
      "lon": lon,
    });
    return map;
  }

  @override
  List<Object?> get props => [...super.props, lat, lon];
}
