import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/features/weather/domain/entities/location_entity.dart';

/// Represents the Repository responsible for retrieving location data.
abstract class LocationRepository {
  /// Returns the current position.
  ///
  /// Throws a [ConvertingException] if the convertion did not work
  /// Throws a [TimeoutException] when no location is received within the supplied [timeLimit] duration.
  /// Throws a [LocationServiceDisabledException] when the user allowed access, but the location services of the device are disabled.
  Future<DataState<LocationEntity>> getLocation();

  /// Returns a [Future] indicating if the user allows the App to access the device's location.
  Future<DataState<LocationPermission>> checkPermission();

  /// Returns a [Future] containing a [bool] value indicating whether location services are enabled on the device.
  Future<DataState<bool>> isLocationServiceEnabled();

  // /Request permission to access the location of the device.
  /// Returns a [Future] which when completes indicates if the user granted permission to access the device's location.
  /// Throws a [PermissionDefinitionsNotFoundException] when the required platform specific configuration is missing (e.g. in the AndroidManifest.xml on Android or the Info.plist on iOS).
  /// A [PermissionRequestInProgressException] is thrown if permissions are requested while an earlier request has not yet been completed.
  Future<DataState<LocationPermission>> requestPermission();
}
