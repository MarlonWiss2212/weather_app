import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_entity.dart';

class WeatherForecastModel extends WeatherForecastEntity {
  WeatherForecastModel({
    required super.lat,
    required super.lon,
    required super.timezone,
    required super.timezoneOffset,
    required super.current,
    required super.minutly,
    required super.hourly,
    required super.daily,
    required super.alerts,
  });

  /// Converts the [json] to the [WeatherForecastModel]
  ///
  /// Throws an [ConvertingException] if the convertion did not work
  factory WeatherForecastModel.fromJSON(Map<String, dynamic> json) {
    try {
      return WeatherForecastModel(
        lat: json["lat"],
        lon: json["lon"],
        timezone: json["timezone"],
        timezoneOffset: json["timezoneOffset"],
        current: null,
        minutly: null,
        hourly: null,
        daily: null,
        alerts: null,
      );
    } catch (e) {
      throw ConvertingException();
    }
  }
}
