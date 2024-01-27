import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_current_entity.dart';

class WeatherForecastEntity {
  final double lat;
  final double lon;
  final String timezone;
  final int timezoneOffset;
  final WeatherForecastCurrentEntity current;
  final dynamic hourly;
  final dynamic daily;
  final dynamic alerts;

  WeatherForecastEntity({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.timezoneOffset,
    required this.current,
    required this.hourly,
    required this.daily,
    required this.alerts,
  });
}
