import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/features/weather/data/repository/location_repository_impl.dart';
import 'package:weather_app/features/weather/domain/entities/location_entity.dart';
import 'package:weather_app/features/weather/domain/usecases/location/get_location.dart';

import 'get_location_test.mocks.dart';

@GenerateMocks([LocationRepositoryImpl])
void main() {
  final MockLocationRepositoryImpl mockLocationRepositoryImpl =
      MockLocationRepositoryImpl();

  group("test 'call' function", () {
    test("should return a failure when location service also return a failure",
        () async {
      // mocking
      when(mockLocationRepositoryImpl.isLocationServiceEnabled()).thenAnswer(
        (_) async => DataState<void>.failure(
          const LocationServiceNotEnabledFailure(),
        ),
      );

      final response = await GetLocationUseCase(
        locationRepository: mockLocationRepositoryImpl,
      ).call();

      expect(
        response,
        DataState<LocationEntity>.failure(
          const LocationServiceNotEnabledFailure(),
        ),
      );
    });
  });
}
