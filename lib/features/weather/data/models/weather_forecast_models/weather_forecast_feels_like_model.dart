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
        day: double.parse(json["day"].toString()),
        night: double.parse(json["night"].toString()),
        eve: double.parse(json["eve"].toString()),
        morn: double.parse(json["morn"].toString()),
      );
    } on ConvertingException {
      rethrow;
    } catch (e) {
      throw ConvertingException();
    }
  }
}
