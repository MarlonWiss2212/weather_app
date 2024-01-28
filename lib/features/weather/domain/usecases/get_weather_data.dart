import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_entity.dart';
import 'package:weather_app/features/weather/domain/repository/weather_repository.dart';

class GetWeatherDataUseCase
    implements UseCase<DataState<WeatherForecastEntity>, void> {
  final WeatherRepository weatherRepository;

  GetWeatherDataUseCase({required this.weatherRepository});

  @override
  Future<DataState<WeatherForecastEntity>> call({void params}) {
    return weatherRepository.getWeatherData();
  }
}
