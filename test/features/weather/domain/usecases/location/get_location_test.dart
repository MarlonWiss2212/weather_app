import 'dart:ffi';

import 'package:geolocator/geolocator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/features/weather/data/models/location_model.dart';
import 'package:weather_app/features/weather/data/repository/location_repository_impl.dart';
import 'package:weather_app/features/weather/domain/entities/location_entity.dart';
import 'package:weather_app/features/weather/domain/usecases/location/get_location.dart';
import 'get_location_test.mocks.dart';

@GenerateMocks([LocationRepositoryImpl])
void main() {
  late MockLocationRepositoryImpl mockLocationRepositoryImpl;

  setUp(() {
    mockLocationRepositoryImpl = MockLocationRepositoryImpl();
  });

  group("test 'call' function", () {
    test("should return the failure that 'isLocationServiceEnabled' returns",
        () async {
      // mocking
      when(mockLocationRepositoryImpl.isLocationServiceEnabled()).thenAnswer(
        (_) async => DataState<void>.failure(
          const LocationServiceNotEnabledFailure(),
        ),
      );

      final DataState<LocationEntity> response = await GetLocationUseCase(
        locationRepository: mockLocationRepositoryImpl,
      ).call();

      final DataState<LocationEntity> expectedResult = DataState.failure(
        const LocationServiceNotEnabledFailure(),
      );

      expect(response, expectedResult);
    });

    test("should return the failure that 'checkPermission' returns", () async {
      // mocking
      when(mockLocationRepositoryImpl.isLocationServiceEnabled()).thenAnswer(
        (_) async => DataState<void>.success(Void),
      );
      when(mockLocationRepositoryImpl.checkPermission()).thenAnswer(
        (_) async => DataState<LocationPermission>.failure(
          const UnkownFailure(),
        ),
      );

      final DataState<LocationEntity> response = await GetLocationUseCase(
        locationRepository: mockLocationRepositoryImpl,
      ).call();

      final DataState<LocationEntity> expectedResult = DataState.failure(
        const UnkownFailure(),
      );

      expect(response, expectedResult);
    });

    test(
        "should return a LocationPermissionDeniedForever failure when 'checkPermission' returns LocationPermission.unableToDetermine",
        () async {
      // mocking
      when(mockLocationRepositoryImpl.isLocationServiceEnabled()).thenAnswer(
        (_) async => DataState<void>.success(Void),
      );
      when(mockLocationRepositoryImpl.checkPermission()).thenAnswer(
        (_) async => DataState<LocationPermission>.success(
          LocationPermission.unableToDetermine,
        ),
      );

      final DataState<LocationEntity> response = await GetLocationUseCase(
        locationRepository: mockLocationRepositoryImpl,
      ).call();

      final DataState<LocationEntity> expectedResult = DataState.failure(
        const LocationPermissionDeniedForever(),
      );

      expect(response, expectedResult);
    });

    test(
        "should return a LocationPermissionDeniedForever failure when 'checkPermission' returns LocationPermission.deniedForever",
        () async {
      // mocking
      when(mockLocationRepositoryImpl.isLocationServiceEnabled()).thenAnswer(
        (_) async => DataState<void>.success(Void),
      );
      when(mockLocationRepositoryImpl.checkPermission()).thenAnswer(
        (_) async => DataState<LocationPermission>.success(
          LocationPermission.deniedForever,
        ),
      );

      final DataState<LocationEntity> response = await GetLocationUseCase(
        locationRepository: mockLocationRepositoryImpl,
      ).call();

      final DataState<LocationEntity> expectedResult = DataState.failure(
        const LocationPermissionDeniedForever(),
      );

      expect(response, expectedResult);
    });

    test(
        "should return the failure that 'requestPermission' permission returns",
        () async {
      // mocking
      when(mockLocationRepositoryImpl.isLocationServiceEnabled()).thenAnswer(
        (_) async => DataState<void>.success(Void),
      );
      when(mockLocationRepositoryImpl.checkPermission()).thenAnswer(
        (_) async => DataState<LocationPermission>.success(
          LocationPermission.denied,
        ),
      );
      when(mockLocationRepositoryImpl.requestPermission()).thenAnswer(
        (_) async => DataState<LocationPermission>.failure(
          const GeneralFailure(),
        ),
      );

      final DataState<LocationEntity> response = await GetLocationUseCase(
        locationRepository: mockLocationRepositoryImpl,
      ).call();

      final DataState<LocationEntity> expectedResult = DataState.failure(
        const GeneralFailure(),
      );

      expect(response, expectedResult);
    });

    test(
        "should return LocationPermissionDenied failure when the permission got denied again after requesting it",
        () async {
      // mocking
      when(mockLocationRepositoryImpl.isLocationServiceEnabled()).thenAnswer(
        (_) async => DataState<void>.success(Void),
      );
      when(mockLocationRepositoryImpl.checkPermission()).thenAnswer(
        (_) async => DataState<LocationPermission>.success(
          LocationPermission.denied,
        ),
      );
      when(mockLocationRepositoryImpl.requestPermission()).thenAnswer(
        (_) async => DataState<LocationPermission>.success(
          LocationPermission.denied,
        ),
      );

      final DataState<LocationEntity> response = await GetLocationUseCase(
        locationRepository: mockLocationRepositoryImpl,
      ).call();

      final DataState<LocationEntity> expectedResult = DataState.failure(
        const LocationPermissionDenied(),
      );

      expect(response, expectedResult);
    });

    test(
        "should return a LocationPermissionDeniedForever failure when 'requestPermission' returns LocationPermission.unableToDetermine",
        () async {
      // mocking
      when(mockLocationRepositoryImpl.isLocationServiceEnabled()).thenAnswer(
        (_) async => DataState<void>.success(Void),
      );
      when(mockLocationRepositoryImpl.checkPermission()).thenAnswer(
        (_) async => DataState<LocationPermission>.success(
          LocationPermission.denied,
        ),
      );
      when(mockLocationRepositoryImpl.checkPermission()).thenAnswer(
        (_) async => DataState<LocationPermission>.success(
          LocationPermission.unableToDetermine,
        ),
      );

      final DataState<LocationEntity> response = await GetLocationUseCase(
        locationRepository: mockLocationRepositoryImpl,
      ).call();

      final DataState<LocationEntity> expectedResult = DataState.failure(
        const LocationPermissionDeniedForever(),
      );

      expect(response, expectedResult);
    });

    test(
        "should return a LocationPermissionDeniedForever failure when 'requestPermission' returns LocationPermission.deniedForever",
        () async {
      // mocking
      when(mockLocationRepositoryImpl.isLocationServiceEnabled()).thenAnswer(
        (_) async => DataState<void>.success(Void),
      );
      when(mockLocationRepositoryImpl.checkPermission()).thenAnswer(
        (_) async => DataState<LocationPermission>.success(
          LocationPermission.denied,
        ),
      );
      when(mockLocationRepositoryImpl.requestPermission()).thenAnswer(
        (_) async => DataState<LocationPermission>.success(
          LocationPermission.deniedForever,
        ),
      );

      final DataState<LocationEntity> response = await GetLocationUseCase(
        locationRepository: mockLocationRepositoryImpl,
      ).call();

      final DataState<LocationEntity> expectedResult = DataState.failure(
        const LocationPermissionDeniedForever(),
      );

      expect(response, expectedResult);
    });

    test(
        "should return the failure of 'getLocation' when permission to receive location was granted",
        () async {
      // mocking
      when(mockLocationRepositoryImpl.isLocationServiceEnabled()).thenAnswer(
        (_) async => DataState<void>.success(Void),
      );
      when(mockLocationRepositoryImpl.checkPermission()).thenAnswer(
        (_) async => DataState<LocationPermission>.success(
          LocationPermission.always,
        ),
      );
      when(mockLocationRepositoryImpl.getLocation()).thenAnswer(
        (_) async => DataState.failure(const LocationTimeoutFailure()),
      );

      final DataState<LocationEntity> response = await GetLocationUseCase(
        locationRepository: mockLocationRepositoryImpl,
      ).call();

      // TODO: use entity and not model
      final DataState<LocationModel> expectedResult = DataState.failure(
        const LocationTimeoutFailure(),
      );

      expect(response, expectedResult);
    });

    test(
        "should return the locationEntity of 'getLocation' when location was received",
        () async {
      // mocking
      when(mockLocationRepositoryImpl.isLocationServiceEnabled()).thenAnswer(
        (_) async => DataState<void>.success(Void),
      );
      when(mockLocationRepositoryImpl.checkPermission()).thenAnswer(
        (_) async => DataState<LocationPermission>.success(
          LocationPermission.always,
        ),
      );
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
      when(mockLocationRepositoryImpl.getLocation()).thenAnswer(
        (_) async => DataState.success(locationModel),
      );

      final DataState<LocationEntity> response = await GetLocationUseCase(
        locationRepository: mockLocationRepositoryImpl,
      ).call();

      // TODO: use entity and not model
      final DataState<LocationModel> expectedResult = DataState.success(
        locationModel,
      );

      expect(response, expectedResult);
    });
  });
}
