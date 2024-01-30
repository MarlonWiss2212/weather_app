import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/features/weather/data/data_sources/local/settings_service.dart';
import 'package:weather_app/features/weather/domain/repository/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsService settingsService;

  const SettingsRepositoryImpl({
    required this.settingsService,
  });

  @override
  Future<DataState<void>> openLocationSettings() async {
    try {
      final openAppSettings = await settingsService.openLocationSettings();
      if (openAppSettings == false) {
        return DataState.failure(OpeningLocationSettingsFailure());
      }
      return DataState.success(null);
    } catch (e) {
      return DataState.failure(UnkownFailure());
    }
  }

  @override
  Future<DataState<void>> openAppSettings() async {
    try {
      final openAppSettings = await settingsService.openAppSettings();
      if (openAppSettings == false) {
        return DataState.failure(OpeningAppSettingsFailure());
      }
      return DataState.success(null);
    } catch (e) {
      return DataState.failure(UnkownFailure());
    }
  }
}
