import 'package:intl/intl.dart';
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
    required super.weekday,
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
        weekday: DateFormat.EEEE("de").format(
          DateTime.fromMillisecondsSinceEpoch(
            json["dt"] * 1000,
          ),
        ),
        sunrise: json["sunrise"],
        sunset: json["sunset"],
        moonrise: json["moonrise"],
        moonset: json["moonset"],
        moonPhase: double.parse(json["moon_phase"].toString()),
        summary: json["summary"],
        temp: WeatherForecastTempModel.fromJson(json["temp"]),
        feelsLike: WeatherForecastFeelsLikeModel.fromJson(json["feels_like"]),
        pressure: json["pressure"],
        humidity: json["humidity"],
        dewPoint: double.parse(json["dew_point"].toString()),
        uvi: double.parse(json["uvi"].toString()),
        pop: double.parse(json["pop"].toString()),
        clouds: json["clouds"],
        windSpeed: double.parse(json["wind_speed"].toString()),
        windDeg: json["wind_deg"],
        windGust: json["rain"] != null
            ? double.parse(json["wind_gust"].toString())
            : null,
        rain:
            json["rain"] != null ? double.parse(json["rain"].toString()) : null,
        snow:
            json["snow"] != null ? double.parse(json["snow"].toString()) : null,
        weather: weather,
      );
    } on ConvertingException {
      rethrow;
    } catch (e) {
      throw ConvertingException(message: e.toString());
    }
  }
}
