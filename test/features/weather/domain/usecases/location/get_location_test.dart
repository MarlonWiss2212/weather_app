import 'package:mockito/annotations.dart';
import 'package:test/test.dart';
import 'package:weather_app/features/weather/data/repository/location_repository_impl.dart';
import 'package:weather_app/features/weather/domain/usecases/location/get_location.dart';

import 'get_location_test.mocks.dart';

@GenerateMocks([LocationRepositoryImpl])
void main() {
  final MockLocationRepositoryImpl mockLocationRepositoryImpl =
      MockLocationRepositoryImpl();

  group("test _checkIfPermissionIsDeniedForever function", () {
    test(
        "should return LocationPermissionDeniedForever when permission status is unableToDetermine",
        () {
      //TODO: implement tests
    });
  });
}
