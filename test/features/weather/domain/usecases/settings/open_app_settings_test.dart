import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/features/weather/data/repository/settings_repository_impl.dart';
import 'package:weather_app/features/weather/domain/usecases/settings/open_app_settings.dart';

import 'open_app_settings_test.mocks.dart';

@GenerateMocks([SettingsRepositoryImpl])
void main() {
  final MockSettingsRepositoryImpl mockRepo = MockSettingsRepositoryImpl();
  group("test 'call' function", () {
    test("should return same result as repository ", () async {
      final expectedResult = DataState<Unit>.success(const Unit());

      // mocking
      when(mockRepo.openAppSettings()).thenAnswer(
        (_) async => expectedResult,
      );

      final result = await OpenAppSettingsUseCase(
        settingsRepository: mockRepo,
      ).call();

      expect(result, expectedResult);
    });
  });
}
