import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_temp_entity.dart';

class WeatherForecastTempModel extends WeatherForecastTempEntity {
  const WeatherForecastTempModel({
    required super.day,
    required super.night,
    required super.eve,
    required super.max,
    required super.min,
    required super.morn,
  });

  /// Converts the [json] to the [WeatherForecastTempModel]
  ///
  /// Throws an [ConvertingException] if the convertion did not work
  factory WeatherForecastTempModel.fromJson(Map<String, dynamic> json) {
    try {
      return WeatherForecastTempModel(
        day: json["day"],
        night: json["night"],
        eve: json["eve"],
        max: json["max"],
        min: json["min"],
        morn: json["morn"],
      );
    } on ConvertingException {
      rethrow;
    } catch (e) {
      throw ConvertingException();
    }
  }
}
