import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/features/weather/domain/repository/settings_repository.dart';

/// Represents the Use Case responsible for opening the device settings.
class OpenAppSettingsUseCase implements UseCase<DataState<void>, void> {
  final SettingsRepository settingsRepository;

  OpenAppSettingsUseCase({required this.settingsRepository});

  @override
  Future<DataState<void>> call({void params}) {
    return settingsRepository.openAppSettings();
  }
}
