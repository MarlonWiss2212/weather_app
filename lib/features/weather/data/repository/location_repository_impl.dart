import 'dart:async';
import 'dart:ffi';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/features/weather/data/data_sources/local/location_service.dart';
import 'package:weather_app/features/weather/data/models/location_model.dart';
import 'package:weather_app/features/weather/domain/repository/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationService locationService;

  LocationRepositoryImpl({
    required this.locationService,
  });

  @override
  Future<DataState<LocationModel>> getLocation() async {
    try {
      final location = await locationService.getLocation();
      return DataState.success(location);
    } on ConvertingException {
      return DataState.failure(const ConvertingFailure());
    } on TimeoutException {
      return DataState.failure(const LocationTimeoutFailure());
    } catch (e) {
      return DataState.failure(const UnkownFailure());
    }
  }

  @override
  Future<DataState<LocationPermission>> checkPermission() async {
    try {
      final permission = await locationService.checkPermission();
      return DataState.success(permission);
    } catch (e) {
      return DataState.failure(const UnkownFailure());
    }
  }

  @override
  Future<DataState<void>> isLocationServiceEnabled() async {
    try {
      final locationServiceEnabled =
          await locationService.isLocationServiceEnabled();
      if (locationServiceEnabled == false) {
        return DataState.failure(const LocationServiceNotEnabledFailure());
      }
      return DataState<void>.success(Void);
    } catch (e) {
      return DataState.failure(const UnkownFailure());
    }
  }

  @override
  Future<DataState<LocationPermission>> requestPermission() async {
    try {
      final permission = await locationService.requestPermission();
      return DataState.success(permission);
    } on PermissionDefinitionsNotFoundException {
      return DataState.failure(const GeneralFailure());
    } on PermissionRequestInProgressException {
      return DataState.failure(const GeneralFailure());
    } catch (e) {
      return DataState.failure(const UnkownFailure());
    }
  }
}
