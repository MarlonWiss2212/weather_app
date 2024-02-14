import 'dart:ffi';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/features/weather/data/data_sources/local/settings_service.dart';
import 'package:weather_app/features/weather/data/repository/settings_repository_impl.dart';
import 'package:weather_app/features/weather/domain/repository/settings_repository.dart';
import 'settings_repository_impl_test.mocks.dart';

@GenerateMocks([SettingsServiceImpl])
void main() {
  final MockSettingsServiceImpl mockService = MockSettingsServiceImpl();
  final SettingsRepository repository = SettingsRepositoryImpl(
    settingsService: mockService,
  );

  group("openLocationSettings function tests", () {
    test("should return null if service returns true", () async {
      when(mockService.openLocationSettings()).thenAnswer((_) async => true);

      // call function to test
      final response = await repository.openLocationSettings();

      expect(response, DataState<void>.success(Void));
    });

    test(
      "should return OpeningLocationSettingsFailure if service returns false",
      () async {
        when(mockService.openLocationSettings()).thenAnswer((_) async => false);

        // call function to test
        final response = await repository.openLocationSettings();

        expect(
          response,
          DataState<void>.failure(const OpeningLocationSettingsFailure()),
        );
      },
    );

    test("should catch all exceptions", () async {
      when(mockService.openLocationSettings()).thenThrow(Exception());

      // call function to test
      final response = await repository.openLocationSettings();

      expect(response, DataState<void>.failure(const UnkownFailure()));
    });
  });

  group("openAppSettings function tests", () {
    test("should return null if service returns true", () async {
      when(mockService.openAppSettings()).thenAnswer((_) async => true);

      // call function to test
      final response = await repository.openAppSettings();

      expect(response, DataState<void>.success(Void));
    });

    test(
      "should return OpeningAppSettingsFailure if service returns false",
      () async {
        when(mockService.openAppSettings()).thenAnswer((_) async => false);

        // call function to test
        final response = await repository.openAppSettings();

        expect(
          response,
          DataState<void>.failure(const OpeningAppSettingsFailure()),
        );
      },
    );

    test("should catch all exceptions", () async {
      when(mockService.openAppSettings()).thenThrow(Exception());

      // call function to test
      final response = await repository.openAppSettings();

      expect(response, DataState<void>.failure(const UnkownFailure()));
    });
  });
}
