import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/features/weather/data/models/weather_forecast_models/weather_forecast_alert_model.dart';
import 'package:weather_app/features/weather/data/models/weather_forecast_models/weather_forecast_current_model.dart';
import 'package:weather_app/features/weather/data/models/weather_forecast_models/weather_forecast_daily_model.dart';
import 'package:weather_app/features/weather/data/models/weather_forecast_models/weather_forecast_hourly_model.dart';
import 'package:weather_app/features/weather/data/models/weather_forecast_models/weather_forecast_minutly_model.dart';
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
      final List<WeatherForecastAlertModel> alerts = [];
      if (json["alerts"] != null) {
        for (final alert in json["alerts"]) {
          alerts.add(WeatherForecastAlertModel.fromJson(alert));
        }
      }

      final List<WeatherForecastMinutlyModel> minutly = [];
      if (json["minutely"] != null) {
        for (final minute in json["minutely"]) {
          minutly.add(WeatherForecastMinutlyModel.fromJson(minute));
        }
      }

      final List<WeatherForecastHourlyModel> hourly = [];
      if (json["hourly"] != null) {
        for (final hour in json["hourly"]) {
          hourly.add(WeatherForecastHourlyModel.fromJson(hour));
        }
      }

      final List<WeatherForecastDailyModel> daily = [];
      if (json["daily"] != null) {
        for (final day in json["daily"]) {
          daily.add(WeatherForecastDailyModel.fromJson(day));
        }
      }

      return WeatherForecastModel(
        lat: json["lat"],
        lon: json["lon"],
        timezone: json["timezone"],
        timezoneOffset: json["timezone_offset"],
        current: WeatherForecastCurrentModel.fromJson(json["current"]),
        minutly: minutly,
        hourly: hourly,
        daily: daily,
        alerts: alerts,
      );
    } on ConvertingException {
      rethrow;
    } catch (e) {
      throw ConvertingException(message: e.toString());
    }
  }
}
