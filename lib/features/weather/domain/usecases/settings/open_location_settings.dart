import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/features/weather/domain/repository/settings_repository.dart';

/// Represents the Use Case responsible for opening the device settings.
class OpenLocationSettingsUseCase implements UseCase<DataState<Unit>, void> {
  final SettingsRepository settingsRepository;

  OpenLocationSettingsUseCase({required this.settingsRepository});

  @override
  Future<DataState<Unit>> call({void params}) {
    return settingsRepository.openLocationSettings();
  }
}
