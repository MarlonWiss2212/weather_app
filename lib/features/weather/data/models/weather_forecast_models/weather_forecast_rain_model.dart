import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_rain_entity.dart';

class WeatherForecastRainModel extends WeatherForecastRainEntity {
  const WeatherForecastRainModel({
    super.oneHour,
  });

  /// Converts the [json] to the [WeatherForecastRainModel]
  ///
  /// Throws an [ConvertingException] if the convertion did not work
  factory WeatherForecastRainModel.fromJson(Map<String, dynamic> json) {
    try {
      return WeatherForecastRainModel(oneHour: json["1h"]);
    } on ConvertingException {
      rethrow;
    } catch (e) {
      throw ConvertingException();
    }
  }
}
