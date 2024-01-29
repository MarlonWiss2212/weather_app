import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/features/location/domain/entities/location_entity.dart';

/// Represents the Repository responsible for retrieving location data.
abstract class LocationRepository {
  /// Returns detailed location information or failure
  Future<DataState<LocationEntity>> getCurrentLocation();

  /// Opens the app settings or returns a failure
  Future<DataState<void>> openAppSettings();

  /// Opens the location settings or returns a failure
  Future<DataState<void>> openLocationSettings();
}
