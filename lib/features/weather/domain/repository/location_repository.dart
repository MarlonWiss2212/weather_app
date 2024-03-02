import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/features/weather/domain/entities/location_entity.dart';

/// Represents the Repository responsible for retrieving location data.
abstract class LocationRepository {
  /// Returns the current [LocationEntity] or a failure.
  Future<DataState<LocationEntity>> getLocation();

  /// Returns a [Future] indicating if the user allows the App to access the device's location or a failure.
  Future<DataState<LocationPermission>> checkPermission();

  /// Returns a [Future] either with [void] or a failure when the locationService is not enabled.
  Future<DataState<Unit>> isLocationServiceEnabled();

  /// Request permission to access the location of the device or a failure.
  Future<DataState<LocationPermission>> requestPermission();
}
