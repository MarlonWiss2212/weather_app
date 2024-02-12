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
      onError: (failure) => DataState.failure(failure),
      onSuccess: (_) async {
        final hasPermission = await _checkAndRequestPermissionIfNeccessary();

        return hasPermission.either(
          onSuccess: (_) async => await locationRepository.getLocation(),
          onError: (failure) => DataState.failure(failure),
        );
      },
    );
  }

  Future<DataState<void>> _checkAndRequestPermissionIfNeccessary() async {
    late LocationPermission permissionStatus;
    Failure? failure;

    // check permission
    final permissionOrFailure = await locationRepository.checkPermission();
    permissionOrFailure.either<void>(
      onSuccess: (permission) => permissionStatus = permission,
      onError: (innerFailure) => failure = innerFailure,
    );

    if (failure != null) {
      return DataState.failure(failure!);
    }

    if (permissionStatus == LocationPermission.denied) {
      // request the permission if it was denied previously
      final permissionOrFailure = await locationRepository.requestPermission();
      permissionOrFailure.either(
        onSuccess: (newPermission) => permissionStatus = newPermission,
        onError: (innerFailure) => failure = innerFailure,
      );
      if (failure != null) {
        return DataState.failure(failure!);
      }

      if (permissionStatus == LocationPermission.denied) {
        return DataState.failure(const LocationPermissionDenied());
      }
    }

    if (permissionStatus == LocationPermission.unableToDetermine) {
      return DataState.failure(const LocationPermissionDeniedForever());
    }
    return DataState.success(null);
  }
}
