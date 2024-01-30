import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/features/weather/domain/entities/location_entity.dart';
import 'package:weather_app/features/weather/domain/repository/location_repository.dart';

/// Represents the Use Case responsible for retrieving location data.
class GetLocationUseCase implements UseCase<DataState<LocationEntity>, void> {
  final LocationRepository locationRepository;

  GetLocationUseCase({required this.locationRepository});

  @override
  Future<DataState<LocationEntity>> call({void params}) {
    return locationRepository.getCurrentLocation();
  }
}
