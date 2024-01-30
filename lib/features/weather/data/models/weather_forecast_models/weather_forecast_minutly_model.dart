import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_minutly_entity.dart';

class WeatherForecastMinutlyModel extends WeatherForecastMinutlyEntity {
  const WeatherForecastMinutlyModel({
    required super.dt,
    required super.precipitation,
  });

  /// Converts the [json] to the [WeatherForecastMinutlyModel]
  ///
  /// Throws an [ConvertingException] if the convertion did not work
  factory WeatherForecastMinutlyModel.fromJson(Map<String, dynamic> json) {
    try {
      return WeatherForecastMinutlyModel(
        dt: json["dt"],
        precipitation: json["sunrise"],
      );
    } on ConvertingException {
      rethrow;
    } catch (e) {
      throw ConvertingException();
    }
  }
}
