import 'package:equatable/equatable.dart';

class GetWeatherParams extends Equatable {
  /// Latitude, decimal (-90; 90). If you need the geocoder to automatic convert city names and zip-codes to geo coordinates and the other way around, please use our Geocoding API [https://openweathermap.org/api/geocoding-api]
  final double lat;

  /// Longitude, decimal (-180; 180). If you need the geocoder to automatic convert city names and zip-codes to geo coordinates and the other way around, please use our Geocoding API [https://openweathermap.org/api/geocoding-api]
  final double lon;

  /// Your unique API key (you can always find it on your account page under the "API key" tab [https://home.openweathermap.org/api_keys])
  final String appid;

  /// By using this parameter you can exclude some parts of the weather data from the API response. It should be a comma-delimited list (without spaces).
  /// Available values:
  /// current
  /// minutely
  /// hourly
  /// daily
  /// alerts
  final String? exclude;

  /// Units of measurement. standard, metric and imperial units are available. If you do not use the units parameter, standard units will be applied by default. Learn more [https://openweathermap.org/api/one-call-3#data]
  final String? units;

  /// You can use the lang parameter to get the output in your language. Learn more [https://openweathermap.org/api/one-call-3#multi]
  final String? lang;

  const GetWeatherParams({
    required this.lat,
    required this.lon,
    required this.appid,
    this.exclude,
    this.units,
    this.lang,
  });

  @override
  List<Object?> get props => [lat, lon, appid, exclude, units, lang];

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{
      'lat': lat,
      'lon': lon,
      'appid': appid,
    };
    if (exclude != null) {
      map['exclude'] = exclude;
    }
    if (units != null) {
      map['units'] = units;
    }
    if (lang != null) {
      map['lang'] = lang;
    }

    return map;
  }
}
