import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/features/weather/data/data_sources/remote/weather_service.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_entity.dart';
import 'package:weather_app/features/weather/domain/repository/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherService weatherService;

  WeatherRepositoryImpl({required this.weatherService});

  @override
  Future<DataState<WeatherForecastEntity>> getWeatherData() {
    return weatherService.getWeatherData();
  }
}
