import 'package:weather_app/core/params/params.dart';
import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_entity.dart';

/// Represents the Repository responsible for retrieving weather data.
abstract class WeatherRepository {
  Future<DataState<WeatherForecastEntity>> getWeatherData({
    required GetWeatherParams params,
  });
}
