import 'package:weather_app/core/params/get_weather_params.dart';
import 'package:weather_app/core/params/get_weather_with_location_params.dart';
import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_entity.dart';
import 'package:weather_app/features/weather/domain/repository/weather_repository.dart';
import 'package:weather_app/features/weather/domain/usecases/location/get_location.dart';

/// Represents the Use Case responsible for retrieving weather data.
class GetWeatherByLocationUseCase
    implements UseCase<DataState<WeatherForecastEntity>, GetWeatherParams> {
  final WeatherRepository weatherRepository;
  final GetLocationUseCase getLocationUseCase;

  GetWeatherByLocationUseCase({
    required this.weatherRepository,
    required this.getLocationUseCase,
  });

  @override
  Future<DataState<WeatherForecastEntity>> call({
    required GetWeatherParams params,
  }) async {
    final locationOrFailure = await getLocationUseCase.call();
    return locationOrFailure.handle(
      onSuccess: (location) => weatherRepository.getWeatherData(
        params: GetWeatherWithLocationParams.fromGetWeatherParams(
          lat: locationOrFailure.data!.latitude,
          lon: locationOrFailure.data!.longitude,
          params: params,
        ),
      ),
      onError: (failure) => DataState.failure(failure),
    );
  }
}
