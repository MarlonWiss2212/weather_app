import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_weather_entity.dart';

class WeatherForecastWeatherModel extends WeatherForecastWeatherEntity {
  const WeatherForecastWeatherModel({
    required super.id,
    required super.main,
    required super.description,
    required super.icon,
  });

  /// Converts the [json] to the [WeatherForecastWeatherModel]
  ///
  /// Throws an [ConvertingException] if the convertion did not work
  factory WeatherForecastWeatherModel.fromJson(Map<String, dynamic> json) {
    try {
      return WeatherForecastWeatherModel(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
      );
    } on ConvertingException {
      rethrow;
    } catch (e) {
      throw ConvertingException();
    }
  }
}
