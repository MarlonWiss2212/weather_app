import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/features/location/domain/repository/location_repository.dart';

/// Represents the Use Case responsible for opening the device settings.
class OpenAppSettingsUseCase implements UseCase<DataState<void>, void> {
  final LocationRepository locationRepository;

  OpenAppSettingsUseCase({required this.locationRepository});

  @override
  Future<DataState<void>> call({void params}) {
    return locationRepository.openAppSettings();
  }
}
