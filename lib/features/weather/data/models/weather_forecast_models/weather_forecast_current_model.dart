import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/features/weather/data/models/weather_forecast_models/weather_forecast_rain_model.dart';
import 'package:weather_app/features/weather/data/models/weather_forecast_models/weather_forecast_snow_model.dart';
import 'package:weather_app/features/weather/data/models/weather_forecast_models/weather_forecast_weather_model.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_current_entity.dart';

class WeatherForecastCurrentModel extends WeatherForecastCurrentEntity {
  const WeatherForecastCurrentModel({
    required super.dt,
    required super.sunrise,
    required super.sunset,
    required super.temp,
    required super.feelsLike,
    required super.pressure,
    required super.humidity,
    required super.dewPoint,
    required super.uvi,
    required super.clouds,
    required super.visibility,
    required super.windSpeed,
    super.windDeg,
    required super.windGust,
    required super.rain,
    required super.snow,
    required super.weather,
  });

  /// Converts the [json] to the [WeatherForecastCurrentModel]
  ///
  /// Throws an [ConvertingException] if the convertion did not work
  factory WeatherForecastCurrentModel.fromJson(Map<String, dynamic> json) {
    try {
      final List<WeatherForecastWeatherModel> weather = [];
      for (final e in json["weather"]) {
        weather.add(WeatherForecastWeatherModel.fromJson(e));
      }

      return WeatherForecastCurrentModel(
        dt: json["dt"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
        temp: json["temp"],
        feelsLike: json["feels_like"],
        pressure: json["pressure"],
        humidity: json["humidity"],
        dewPoint: json["dew_point"],
        uvi: json["uvi"],
        clouds: json["clouds"],
        visibility: json["visibility"],
        windSpeed: json["wind_speed"],
        windDeg: json["wind_deg"],
        windGust: json["wind_gust"],
        rain: WeatherForecastRainModel.fromJson(json["rain"]),
        snow: WeatherForecastSnowModel.fromJson(json["snow"]),
        weather: weather,
      );
    } on ConvertingException {
      rethrow;
    } catch (e) {
      throw ConvertingException();
    }
  }
}
