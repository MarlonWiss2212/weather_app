import 'package:equatable/equatable.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_rain_entity.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_snow_entity.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_weather_entity.dart';

/// Current weather data API response
class WeatherForecastCurrentEntity extends Equatable {
  /// Current time, Unix, UTC
  final int dt;

  /// Sunrise time, Unix, UTC. For polar areas in midnight sun and polar night periods this parameter is not returned in the response
  final int sunrise;

  /// Sunset time, Unix, UTC. For polar areas in midnight sun and polar night periods this parameter is not returned in the response
  final int sunset;

  /// Temperature. Units - default: kelvin, metric: Celsius, imperial: Fahrenheit. How to change units used [https://openweathermap.org/api/one-call-3#data]
  final double temp;

  /// Temperature. This temperature parameter accounts for the human perception of weather. Units – default: kelvin, metric: Celsius, imperial: Fahrenheit.
  final double feelsLike;

  /// Atmospheric pressure on the sea level, hPa
  final int pressure;

  /// Humidity, %
  final int humidity;

  /// Atmospheric temperature (varying according to pressure and humidity) below which water droplets begin to condense and dew can form. Units – default: kelvin, metric: Celsius, imperial: Fahrenheit
  final double dewPoint;

  /// Cloudiness, %
  final int clouds;

  /// Current UV index.
  final double uvi;

  /// Average visibility, metres. The maximum value of the visibility is 10 km
  final int visibility;

  /// Wind speed. Wind speed. Units – default: metre/sec, metric: metre/sec, imperial: miles/hour. How to change units used [https://openweathermap.org/api/one-call-3#data]
  final double windSpeed;

  /// Wind direction, degrees (meteorological)
  final double? windDeg;

  /// (where available) Wind gust. Units – default: metre/sec, metric: metre/sec, imperial: miles/hour. How to change units used [https://openweathermap.org/api/one-call-3#data]
  final double windGust;

  /// Rain
  final WeatherForecastRainEntity rain;

  /// Snow
  final WeatherForecastSnowEntity snow;

  /// Weather
  final List<WeatherForecastWeatherEntity> weather;

  const WeatherForecastCurrentEntity({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.uvi,
    required this.clouds,
    required this.visibility,
    required this.windSpeed,
    this.windDeg,
    required this.windGust,
    required this.rain,
    required this.snow,
    required this.weather,
  });

  @override
  List<Object?> get props {
    return [
      dt,
      sunrise,
      sunset,
      temp,
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
    ];
  }
}
