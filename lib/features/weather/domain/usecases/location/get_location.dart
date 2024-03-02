import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/features/weather/domain/entities/location_entity.dart';
import 'package:weather_app/features/weather/domain/repository/location_repository.dart';

/// Represents the Use Case responsible for retrieving location data.
class GetLocationUseCase implements UseCase<DataState<LocationEntity>, void> {
  final LocationRepository locationRepository;

  GetLocationUseCase({required this.locationRepository});

  @override
  Future<DataState<LocationEntity>> call({void params}) async {
    final serviceEnabledOrFailure =
        await locationRepository.isLocationServiceEnabled();

    return await serviceEnabledOrFailure.either(
      onSuccess: (_) async {
        final hasPermission = await _checkPermissionWithRequestWhenDenied();

        return hasPermission.either(
          onSuccess: (_) async => await locationRepository.getLocation(),
          onError: (failure) => DataState.failure(failure),
        );
      },
      onError: (failure) => DataState.failure(failure),
    );
  }

  Future<DataState<Unit>> _checkPermissionWithRequestWhenDenied() async {
    final permissionOrFailure = await locationRepository.checkPermission();
    return await permissionOrFailure.either(
      onSuccess: (permissionStatus) => _requestPermissionIfNeccessary(
        permissionStatus,
      ),
      onError: (failure) => DataState.failure(failure),
    );
  }

  Future<DataState<Unit>> _requestPermissionIfNeccessary(
    LocationPermission permissionStatus,
  ) async {
    if (permissionStatus == LocationPermission.denied) {
      return await _requestPermissionAndCheckItsStatus();
    } else {
      return _checkIfPermissionIsDeniedForever(permissionStatus);
    }
  }

  Future<DataState<Unit>> _requestPermissionAndCheckItsStatus() async {
    final permissionOrFailure = await locationRepository.requestPermission();
    return permissionOrFailure.either(
      onSuccess: (permissionStatus) {
        if (permissionStatus == LocationPermission.denied) {
          return DataState.failure(const LocationPermissionDenied());
        }
        return _checkIfPermissionIsDeniedForever(permissionStatus);
      },
      onError: (failure) => DataState.failure(failure),
    );
  }

  DataState<Unit> _checkIfPermissionIsDeniedForever(
    LocationPermission permissionStatus,
  ) {
    if (permissionStatus == LocationPermission.unableToDetermine ||
        permissionStatus == LocationPermission.deniedForever) {
      return DataState.failure(const LocationPermissionDeniedForever());
    }
    return DataState<Unit>.success(const Unit());
  }
}
