import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_entity.dart';

abstract class WeatherRepository {
  Future<DataState<WeatherForecastEntity>> getWeatherData();
}