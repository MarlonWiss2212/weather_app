import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/features/weather/data/models/weather_forecast_models/weather_forecast_feels_like_model.dart';
import 'package:weather_app/features/weather/data/models/weather_forecast_models/weather_forecast_temp_model.dart';
import 'package:weather_app/features/weather/data/models/weather_forecast_models/weather_forecast_weather_model.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_daily_entity.dart';

class WeatherForecastDailyModel extends WeatherForecastDailyEntity {
  const WeatherForecastDailyModel({
    required super.dt,
    required super.sunrise,
    required super.sunset,
    required super.moonrise,
    required super.moonset,
    required super.moonPhase,
    required super.summary,
    required super.temp,
    required super.feelsLike,
    required super.pressure,
    required super.humidity,
    required super.dewPoint,
    required super.uvi,
    required super.pop,
    required super.clouds,
    required super.windSpeed,
    required super.windDeg,
    required super.weather,
    super.rain,
    super.snow,
    super.windGust,
  });

  /// Converts the [json] to the [WeatherForecastDailyModel]
  ///
  /// Throws an [ConvertingException] if the convertion did not work
  factory WeatherForecastDailyModel.fromJson(Map<String, dynamic> json) {
    try {
      final List<WeatherForecastWeatherModel> weather = [];
      for (final e in json["weather"]) {
        weather.add(WeatherForecastWeatherModel.fromJson(e));
      }

      return WeatherForecastDailyModel(
        dt: json["dt"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
        moonrise: json["moonrise"],
        moonset: json["moonset"],
        moonPhase: json["moon_phase"],
        summary: json["summary"],
        temp: WeatherForecastTempModel.fromJson(json["temp"]),
        feelsLike: WeatherForecastFeelsLikeModel.fromJson(json["feels_like"]),
        pressure: json["pressure"],
        humidity: json["humidity"],
        dewPoint: json["dew_point"],
        uvi: json["uvi"],
        pop: json["pop"],
        clouds: json["clouds"],
        windSpeed: json["wind_speed"],
        windDeg: json["wind_deg"],
        windGust: json["wind_gust"],
        rain: json["rain"],
        snow: json["snow"],
        weather: weather,
      );
    } on ConvertingException {
      rethrow;
    } catch (e) {
      throw ConvertingException();
    }
  }
}
