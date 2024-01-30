import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_feels_like_entity.dart';

class WeatherForecastFeelsLikeModel extends WeatherForecastFeelsLikeEntity {
  const WeatherForecastFeelsLikeModel({
    required super.day,
    required super.night,
    required super.eve,
    required super.morn,
  });

  /// Converts the [json] to the [WeatherForecastFeelsLikeModel]
  ///
  /// Throws an [ConvertingException] if the convertion did not work
  factory WeatherForecastFeelsLikeModel.fromJson(Map<String, dynamic> json) {
    try {
      return WeatherForecastFeelsLikeModel(
        day: json["day"],
        night: json["night"],
        eve: json["eve"],
        morn: json["morn"],
      );
    } on ConvertingException {
      rethrow;
    } catch (e) {
      throw ConvertingException();
    }
  }
}
