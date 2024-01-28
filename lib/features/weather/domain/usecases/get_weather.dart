import 'package:weather_app/core/params/params.dart';
import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_entity.dart';
import 'package:weather_app/features/weather/domain/repository/weather_repository.dart';

/// Represents the Use Case responsible for retrieving weather data.
class GetWeatherUseCase
    implements UseCase<DataState<WeatherForecastEntity>, GetWeatherParams> {
  final WeatherRepository weatherRepository;

  GetWeatherUseCase({required this.weatherRepository});

  @override
  Future<DataState<WeatherForecastEntity>> call({
    required GetWeatherParams params,
  }) {
    return weatherRepository.getWeatherData(params: params);
  }
}
