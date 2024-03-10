import 'package:equatable/equatable.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_rain_entity.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_snow_entity.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_weather_entity.dart';

/// Hourly forecast weather data API response
class WeatherForecastHourlyEntity extends Equatable {
  /// Time of the forecasted data, Unix, UTC
  final int dt;

  /// Temperature. Units – default: kelvin, metric: Celsius, imperial: Fahrenheit. How to change units used [https://openweathermap.org/api/one-call-3#data]
  final double temp;

  /// Temperature. This accounts for the human perception of weather. Units – default: kelvin, metric: Celsius, imperial: Fahrenheit.
  final double feelsLike;

  /// Atmospheric pressure on the sea level, hPa
  final int pressure;

  /// Humidity, %
  final int humidity;

  /// Atmospheric temperature (varying according to pressure and humidity) below which water droplets begin to condense and dew can form. Units – default: kelvin, metric: Celsius, imperial: Fahrenheit.
  final double dewPoint;

  /// UV index
  final double uvi;

  /// Cloudiness, %
  final int clouds;

  /// Average visibility, metres. The maximum value of the visibility is 10 km
  final int? visibility;

  /// Wind speed. Units – default: metre/sec, metric: metre/sec, imperial: miles/hour.How to change units used [https://openweathermap.org/api/one-call-3#data]
  final double windSpeed;

  /// Wind direction, degrees (meteorological)
  final int windDeg;

  /// (where available) Wind gust. Units – default: metre/sec, metric: metre/sec, imperial: miles/hour. How to change units used [https://openweathermap.org/api/one-call-3#data]
  final double? windGust;

  /// Weather
  final List<WeatherForecastWeatherEntity> weather;

  /// Rain
  final WeatherForecastRainEntity? rain;

  /// Snow
  final WeatherForecastSnowEntity? snow;

  /// Probability of precipitation. The values of the parameter vary between 0 and 1, where 0 is equal to 0%, 1 is equal to 100%
  final double pop;

  const WeatherForecastHourlyEntity({
    required this.dt,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.uvi,
    required this.clouds,
    this.visibility,
    this.snow,
    this.rain,
    required this.windSpeed,
    required this.windDeg,
    this.windGust,
    required this.weather,
    required this.pop,
  });

  @override
  List<Object?> get props {
    return [
      dt,
      temp,
      snow,
      rain,
      feelsLike,
      pressure,
      humidity,
      dewPoint,
      uvi,
      clouds,
      visibility,
      windSpeed,
      windDeg,
      windGust,
      weather,
      pop,
    ];
  }
}
