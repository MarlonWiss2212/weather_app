import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/features/weather/domain/entities/geocoding/reverse_geocoding_entity.dart';

class ReverseGeocodingModel extends ReverseGeocodingEntity {
  const ReverseGeocodingModel({
    required super.name,
    required super.localNames,
    required super.lat,
    required super.lon,
    required super.country,
    required super.state,
  });

  factory ReverseGeocodingModel.fromJson(Map<String, dynamic> json) {
    try {
      final Map<String, dynamic>? oldMap = json["local_names"];
      final Map<String, String> localNames = Map<String, String>.from(
        oldMap?.cast<String, String>() ?? {},
      );

      return ReverseGeocodingModel(
        name: json["name"],
        localNames: localNames,
        lat: double.parse(json["lat"].toString()),
        lon: double.parse(json["lon"].toString()),
        country: json["country"],
        state: json["state"],
      );
    } on ConvertingException {
      rethrow;
    } catch (e) {
      throw ConvertingException(message: e.toString());
    }
  }
}
