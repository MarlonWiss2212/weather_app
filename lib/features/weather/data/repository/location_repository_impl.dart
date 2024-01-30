import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/features/weather/data/data_sources/local/location_service.dart';
import 'package:weather_app/features/weather/domain/entities/location_entity.dart';
import 'package:weather_app/features/weather/domain/repository/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationService locationService;

  LocationRepositoryImpl({
    required this.locationService,
  });

  @override
  Future<DataState<LocationEntity>> getLocation() async {
    try {
      final location = await locationService.getLocation();
      return DataState.success(location);
    } on LocationServiceDisabledException {
      return DataState.failure(LocationServiceNotEnabledFailure());
    } on ConvertingException {
      return DataState.failure(ConvertingFailure());
    } on TimeoutException {
      return DataState.failure(LocationTimeoutFailure());
    } catch (e) {
      return DataState.failure(UnkownFailure());
    }
  }

  @override
  Future<DataState<LocationPermission>> checkPermission() async {
    try {
      final permission = await locationService.checkPermission();
      return DataState.success(permission);
    } catch (e) {
      return DataState.failure(UnkownFailure());
    }
  }

  @override
  Future<DataState<void>> isLocationServiceEnabled() async {
    try {
      final locationServiceEnabled =
          await locationService.isLocationServiceEnabled();
      if (locationServiceEnabled == false) {
        return DataState.failure(LocationServiceNotEnabledFailure());
      }
      return DataState.success(null);
    } catch (e) {
      return DataState.failure(UnkownFailure());
    }
  }

  @override
  Future<DataState<LocationPermission>> requestPermission() async {
    try {
      final permission = await locationService.requestPermission();
      return DataState.success(permission);
    } on PermissionDefinitionsNotFoundException {
      return DataState.failure(GeneralFailure());
    } on PermissionRequestInProgressException {
      return DataState.failure(GeneralFailure());
    } catch (e) {
      return DataState.failure(UnkownFailure());
    }
  }
}
