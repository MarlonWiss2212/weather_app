import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/features/location/domain/entities/location_entity.dart';

class LocationModel extends LocationEntity {
  const LocationModel({
    required super.longitude,
    required super.latitude,
    required super.timestamp,
    required super.accuracy,
    required super.altitude,
    required super.altitudeAccuracy,
    required super.heading,
    required super.headingAccuracy,
    required super.speed,
    required super.speedAccuracy,
    super.floor,
    super.isMocked,
  });

  /// Converts the [Position] to the [LocationModel]
  ///
  /// Throws an [ConvertingException] if the convertion did not work
  factory LocationModel.fromPostition(Position position) {
    try {
      return LocationModel(
        longitude: position.longitude,
        latitude: position.latitude,
        timestamp: position.timestamp,
        accuracy: position.accuracy,
        altitude: position.altitude,
        altitudeAccuracy: position.altitudeAccuracy,
        heading: position.heading,
        headingAccuracy: position.headingAccuracy,
        speed: position.speed,
        speedAccuracy: position.speedAccuracy,
      );
    } catch (e) {
      throw ConvertingException();
    }
  }
}
