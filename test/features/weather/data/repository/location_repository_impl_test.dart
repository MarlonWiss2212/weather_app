import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/features/weather/data/data_sources/local/location_service.dart';
import 'package:weather_app/features/weather/data/models/location_model.dart';
import 'package:weather_app/features/weather/data/repository/location_repository_impl.dart';
import 'package:weather_app/features/weather/domain/entities/location_entity.dart';
import 'location_repository_impl_test.mocks.dart';

@GenerateMocks([LocationServiceImpl])
void main() {
  final MockLocationServiceImpl mockService = MockLocationServiceImpl();

  group("getLocation function tests", () {
    test("should return location model like the datasource", () async {
      // mocking
      final LocationModel locationModel = LocationModel(
        longitude: 10,
        latitude: 10,
        timestamp: DateTime.now(),
        accuracy: 10,
        altitude: 10,
        altitudeAccuracy: 10,
        heading: 10,
        headingAccuracy: 10,
        speed: 10,
        speedAccuracy: 10,
      );
      final LocationEntity locationEntity = locationModel;
      when(mockService.getLocation()).thenAnswer((_) async => locationModel);

      // call function to test
      final response = await LocationRepositoryImpl(
        locationService: mockService,
      ).getLocation();

      expect(response, DataState.success(locationEntity));
    });

    test("should catch LocationServiceDisabledException", () async {
      // mocking
      when(mockService.getLocation()).thenThrow(ConvertingException());

      // call function to test
      final response = await LocationRepositoryImpl(
        locationService: mockService,
      ).getLocation();

      expect(response,
          DataState<LocationEntity>.failure(const ConvertingFailure()));
    });

    test("should catch TimeoutException", () async {
      // mocking
      when(mockService.getLocation()).thenThrow(TimeoutException(""));

      // call function to test
      final response = await LocationRepositoryImpl(
        locationService: mockService,
      ).getLocation();

      expect(
        response,
        DataState<LocationEntity>.failure(const LocationTimeoutFailure()),
      );
    });

    test("should catch all Exception", () async {
      // mocking
      when(mockService.getLocation()).thenThrow(Exception());

      // call function to test
      final response = await LocationRepositoryImpl(
        locationService: mockService,
      ).getLocation();

      expect(
        response,
        DataState<LocationEntity>.failure(const UnkownFailure()),
      );
    });
  });

  group("checkPermission function tests", () {
    test("should return permission value from datasource", () async {
      // mocking
      final MockLocationServiceImpl mockService = MockLocationServiceImpl();
      const LocationPermission permission = LocationPermission.denied;
      when(mockService.checkPermission()).thenAnswer((_) async => permission);

      // call function to test
      final response = await LocationRepositoryImpl(
        locationService: mockService,
      ).checkPermission();

      expect(response, DataState.success(permission));
    });

    test("should catch all Exception", () async {
      // mocking
      final MockLocationServiceImpl mockService = MockLocationServiceImpl();
      when(mockService.checkPermission()).thenThrow(Exception());

      // call function to test
      final response = await LocationRepositoryImpl(
        locationService: mockService,
      ).checkPermission();

      expect(
        response,
        DataState<LocationPermission>.failure(const UnkownFailure()),
      );
    });
  });

  group("isLocationServiceEnabled function tests", () {
    test("should return null if service is enabled", () async {
      // mocking
      final MockLocationServiceImpl mockService = MockLocationServiceImpl();
      when(mockService.isLocationServiceEnabled()).thenAnswer(
        (_) async => true,
      );

      // call function to test
      final response = await LocationRepositoryImpl(
        locationService: mockService,
      ).isLocationServiceEnabled();

      expect(response, DataState<void>.success(null));
    });

    test(
        "should return LocationServiceNotEnabledFailure when service is not enabled",
        () async {
      // mocking
      final MockLocationServiceImpl mockService = MockLocationServiceImpl();
      when(mockService.isLocationServiceEnabled()).thenAnswer(
        (_) async => false,
      );

      // call function to test
      final response = await LocationRepositoryImpl(
        locationService: mockService,
      ).isLocationServiceEnabled();

      expect(
        response,
        DataState<void>.failure(const LocationServiceNotEnabledFailure()),
      );
    });

    test("should catch all Exception", () async {
      // mocking
      final MockLocationServiceImpl mockService = MockLocationServiceImpl();
      when(mockService.isLocationServiceEnabled()).thenThrow(Exception());

      // call function to test
      final response = await LocationRepositoryImpl(
        locationService: mockService,
      ).isLocationServiceEnabled();

      expect(
        response,
        DataState<void>.failure(const UnkownFailure()),
      );
    });
  });

  group("requestPermission function tests", () {
    test("should return permission value from datasource", () async {
      // mocking
      final MockLocationServiceImpl mockService = MockLocationServiceImpl();
      const LocationPermission permission = LocationPermission.denied;
      when(mockService.requestPermission()).thenAnswer((_) async => permission);

      // call function to test
      final response = await LocationRepositoryImpl(
        locationService: mockService,
      ).requestPermission();

      expect(response, DataState.success(permission));
    });

    test(
        "should return GeneralFailure when datasource throws PermissionDefinitionsNotFoundException",
        () async {
      // mocking
      final MockLocationServiceImpl mockService = MockLocationServiceImpl();
      when(mockService.requestPermission()).thenThrow(
        const PermissionDefinitionsNotFoundException(""),
      );

      // call function to test
      final response = await LocationRepositoryImpl(
        locationService: mockService,
      ).requestPermission();

      expect(
        response,
        DataState<LocationPermission>.failure(const GeneralFailure()),
      );
    });

    test(
        "should return GeneralFailure when datasource throws PermissionRequestInProgressException",
        () async {
      // mocking
      final MockLocationServiceImpl mockService = MockLocationServiceImpl();
      when(mockService.requestPermission()).thenThrow(
        const PermissionRequestInProgressException(""),
      );

      // call function to test
      final response = await LocationRepositoryImpl(
        locationService: mockService,
      ).requestPermission();

      expect(
        response,
        DataState<LocationPermission>.failure(const GeneralFailure()),
      );
    });

    test("should catch all Exception", () async {
      // mocking
      final MockLocationServiceImpl mockService = MockLocationServiceImpl();
      when(mockService.isLocationServiceEnabled()).thenThrow(Exception());

      // call function to test
      final response = await LocationRepositoryImpl(
        locationService: mockService,
      ).isLocationServiceEnabled();

      expect(
        response,
        DataState<void>.failure(const UnkownFailure()),
      );
    });
  });
}
