import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_current_entity.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_daily_entity.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_hourly_entity.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_minutly_entity.dart';

/// Current and forecast weather data
class WeatherForecastEntity {
  /// Latitude of the location, decimal (−90; 90)
  final double lat;

  /// Longitude of the location, decimal (-180; 180)
  final double lon;

  /// Timezone name for the requested location
  final String timezone;

  /// Shift in seconds from UTC
  final int timezoneOffset;

  /// Current weather data API response
  final WeatherForecastCurrentEntity current;

  /// Minute forecast weather data API response
  final List<WeatherForecastMinutlyEntity> minutly;

  /// Hourly forecast weather data API response
  final List<WeatherForecastHourlyEntity> hourly;

  ///  Daily forecast weather data API response
  final List<WeatherForecastDailyEntity> daily;

  /// National weather alerts data from major national weather warning systems
  final dynamic alerts;

  WeatherForecastEntity({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.timezoneOffset,
    required this.current,
    required this.minutly,
    required this.hourly,
    required this.daily,
    required this.alerts,
  });
}
