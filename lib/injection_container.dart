import "package:dio/dio.dart";
import "package:get_it/get_it.dart";
import "package:weather_app/core/constants/constants.dart";
import "package:weather_app/features/weather/data/data_sources/local/location_service.dart";
import "package:weather_app/features/weather/data/data_sources/local/settings_service.dart";
import "package:weather_app/features/weather/data/data_sources/remote/weather_service.dart";
import "package:weather_app/features/weather/data/repository/location_repository_impl.dart";
import "package:weather_app/features/weather/data/repository/settings_repository_impl.dart";
import "package:weather_app/features/weather/data/repository/weather_repository_impl.dart";
import "package:weather_app/features/weather/domain/repository/location_repository.dart";
import "package:weather_app/features/weather/domain/repository/settings_repository.dart";
import "package:weather_app/features/weather/domain/repository/weather_repository.dart";

import "package:weather_app/features/weather/domain/usecases/location/get_location.dart";
import "package:weather_app/features/weather/domain/usecases/settings/open_app_settings.dart";
import "package:weather_app/features/weather/domain/usecases/settings/open_location_settings.dart";
import "package:weather_app/features/weather/domain/usecases/weather/get_weather_by_location.dart";

final sl = GetIt.instance;

/// initializes dependecy injection
Future<void> initializeDependencies() async {
  // usecases
  sl.registerSingleton<GetLocationUseCase>(
    GetLocationUseCase(locationRepository: sl()),
  );
  sl.registerSingleton<OpenAppSettingsUseCase>(
    OpenAppSettingsUseCase(settingsRepository: sl()),
  );
  sl.registerSingleton<OpenLocationSettingsUseCase>(
    OpenLocationSettingsUseCase(settingsRepository: sl()),
  );
  sl.registerSingleton<GetWeatherByLocationUseCase>(
    GetWeatherByLocationUseCase(
      weatherRepository: sl(),
      getLocationUseCase: sl(),
    ),
  );

  //repositories
  sl.registerSingleton<WeatherRepository>(
    WeatherRepositoryImpl(weatherService: sl()),
  );
  sl.registerSingleton<LocationRepository>(
    LocationRepositoryImpl(locationService: sl()),
  );
  sl.registerSingleton<SettingsRepository>(
    SettingsRepositoryImpl(settingsService: sl()),
  );

  //data sources
  sl.registerSingleton<LocationService>(LocationServiceImpl());
  sl.registerSingleton<SettingsService>(SettingsServiceImpl());
  sl.registerSingleton<WeatherService>(WeatherServiceImpl(
    dio: Dio(BaseOptions(baseUrl: apiBaseUrl)),
  ));
}
