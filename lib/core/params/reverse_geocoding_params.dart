import 'package:equatable/equatable.dart';
import 'package:weather_app/core/params/get_weather_with_location_params.dart';

class ReverseGeocodingParams extends Equatable {
  /// Your unique API key (you can always find it on your account page under the "API key" tab [https://home.openweathermap.org/api_keys])
  final String appid;

  /// Geographical coordinate latitude
  final double lat;

  /// Geographical coordinate longitude
  final double lon;

  const ReverseGeocodingParams({
    required this.appid,
    required this.lat,
    required this.lon,
  });

  @override
  List<Object?> get props {
    return [
      appid,
      lat,
      lon,
    ];
  }

  factory ReverseGeocodingParams.fromGetWeatherWithLocationParams({
    required GetWeatherWithLocationParams params,
  }) {
    return ReverseGeocodingParams(
      appid: params.appid,
      lat: params.lat,
      lon: params.lon,
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{
      'appid': appid,
      'lat': lat,
      'lon': lon,
    };
    return map;
  }
}
