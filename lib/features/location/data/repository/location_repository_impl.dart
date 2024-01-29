import 'dart:async';
import 'dart:ffi';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/features/location/data/data_sources/local/device_service.dart';
import 'package:weather_app/features/location/data/data_sources/local/location_service.dart';
import 'package:weather_app/features/location/domain/entities/location_entity.dart';
import 'package:weather_app/features/location/domain/repository/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final DeviceService deviceService;
  final LocationService locationService;

  LocationRepositoryImpl({
    required this.deviceService,
    required this.locationService,
  });

  @override
  Future<DataState<LocationEntity>> getCurrentLocation() async {
    try {
      bool serviceEnabled = false;

      // Test if location services are enabled.
      serviceEnabled = await locationService.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return DataFailed(LocationServiceNotEnabledFailure());
      }

      LocationPermission permission = await locationService.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await locationService.requestPermission();
        if (permission == LocationPermission.denied) {
          return DataFailed(LocationPermissionDenied());
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return DataFailed(LocationPermissionDeniedForever());
      }

      final location = await locationService.getLocation();
      return DataSuccess(location);
    } on LocationServiceDisabledException {
      return DataFailed(LocationServiceNotEnabledFailure());
    } on PermissionDefinitionsNotFoundException {
      return DataFailed(GeneralFailure());
    } on PermissionRequestInProgressException {
      return DataFailed(GeneralFailure());
    } on ConvertingException {
      return DataFailed(ConvertingFailure());
    } on TimeoutException {
      return DataFailed(LocationTimeoutFailure());
    } catch (e) {
      return DataFailed(UnkownFailure());
    }
  }

  @override
  Future<DataState<void>> openLocationSettings() async {
    try {
      final openAppSettings = await deviceService.openLocationSettings();
      if (openAppSettings == false) {
        return DataFailed(OpeningLocationSettingsFailure());
      }

      // ignore: void_checks
      return const DataSuccess(Void);
    } catch (e) {
      return DataFailed(UnkownFailure());
    }
  }

  @override
  Future<DataState<void>> openAppSettings() async {
    try {
      final openAppSettings = await deviceService.openAppSettings();
      if (openAppSettings == false) {
        return DataFailed(OpeningAppSettingsFailure());
      }

      // ignore: void_checks
      return const DataSuccess(Void);
    } catch (e) {
      return DataFailed(UnkownFailure());
    }
  }
}
