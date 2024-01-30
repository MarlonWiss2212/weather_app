import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/features/weather/domain/entities/location_entity.dart';

/// Represents the Repository responsible for retrieving location data.
abstract class LocationRepository {
  /// Returns detailed location information or failure
  Future<DataState<LocationEntity>> getCurrentLocation();
}
