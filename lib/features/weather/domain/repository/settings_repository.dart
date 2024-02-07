import 'package:weather_app/core/resources/data_state.dart';

/// Represents the Repository responsible for retrieving settings data.
abstract class SettingsRepository {
  /// Opens the app settings or returns a failure
  Future<DataState<void>> openAppSettings();

  /// Opens the location settings or returns a failure
  Future<DataState<void>> openLocationSettings();
}
