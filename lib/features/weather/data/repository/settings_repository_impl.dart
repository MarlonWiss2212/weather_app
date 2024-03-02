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
  Future<DataState<Unit>> openLocationSettings() async {
    try {
      final openAppSettings = await settingsService.openLocationSettings();
      if (openAppSettings == false) {
        return DataState.failure(const OpeningLocationSettingsFailure());
      }
      return DataState<Unit>.success(const Unit());
    } catch (e) {
      return DataState<Unit>.failure(const UnkownFailure());
    }
  }

  @override
  Future<DataState<Unit>> openAppSettings() async {
    try {
      final openAppSettings = await settingsService.openAppSettings();
      if (openAppSettings == false) {
        return DataState.failure(const OpeningAppSettingsFailure());
      }
      return DataState<Unit>.success(const Unit());
    } catch (e) {
      return DataState<Unit>.failure(const UnkownFailure());
    }
  }
}
