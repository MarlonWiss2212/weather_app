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
        day: double.parse(json["day"].toString()),
        night: double.parse(json["night"].toString()),
        eve: double.parse(json["eve"].toString()),
        max: double.parse(json["max"].toString()),
        min: double.parse(json["min"].toString()),
        morn: double.parse(json["morn"].toString()),
      );
    } on ConvertingException {
      rethrow;
    } catch (e) {
      throw ConvertingException(message: e.toString());
    }
  }
}
