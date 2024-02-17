import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/features/weather/data/models/weather_forecast_models/weather_forecast_rain_model.dart';
import 'package:weather_app/features/weather/data/models/weather_forecast_models/weather_forecast_snow_model.dart';
import 'package:weather_app/features/weather/data/models/weather_forecast_models/weather_forecast_weather_model.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_hourly_entity.dart';

class WeatherForecastHourlyModel extends WeatherForecastHourlyEntity {
  const WeatherForecastHourlyModel({
    required super.dt,
    required super.temp,
    required super.feelsLike,
    required super.pressure,
    required super.humidity,
    required super.dewPoint,
    required super.uvi,
    required super.clouds,
    required super.visibility,
    required super.snow,
    required super.rain,
    required super.windSpeed,
    required super.windDeg,
    super.windGust,
    required super.weather,
    required super.pop,
  });

  /// Converts the [json] to the [WeatherForecastHourlyModel]
  ///
  /// Throws an [ConvertingException] if the convertion did not work
  factory WeatherForecastHourlyModel.fromJson(Map<String, dynamic> json) {
    try {
      final List<WeatherForecastWeatherModel> weather = [];
      for (final e in json["weather"]) {
        weather.add(WeatherForecastWeatherModel.fromJson(e));
      }

      return WeatherForecastHourlyModel(
        dt: json["dt"],
        temp: double.parse(json["temp"].toString()),
        feelsLike: double.parse(json["feels_like"].toString()),
        pressure: json["pressure"],
        humidity: json["humidity"],
        dewPoint: double.parse(json["dew_point"].toString()),
        uvi: double.parse(json["uvi"].toString()),
        pop: double.parse(json["pop"].toString()),
        clouds: json["clouds"],
        windSpeed: double.parse(json["wind_speed"].toString()),
        windDeg: json["wind_deg"],
        windGust: double.parse(json["wind_gust"].toString()),
        rain: json["rain"] != null
            ? WeatherForecastRainModel.fromJson(json["rain"])
            : null,
        snow: json["snow"] != null
            ? WeatherForecastSnowModel.fromJson(json["snow"])
            : null,
        weather: weather,
        visibility: json["visibility"],
      );
    } on ConvertingException {
      rethrow;
    } catch (e) {
      throw ConvertingException(message: e.toString());
    }
  }
}
