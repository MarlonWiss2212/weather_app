import 'package:equatable/equatable.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_feels_like_entity.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_temp_entity.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_weather_entity.dart';

/// Daily forecast weather data API response
class WeatherForecastDailyEntity extends Equatable {
  /// Time of the forecasted data, Unix, UTC
  final int dt;

  /// Weekday of dt as string
  final String weekday;

  /// Sunrise time, Unix, UTC. For polar areas in midnight sun and polar night periods this parameter is not returned in the response
  final int sunrise;

  /// Sunset time, Unix, UTC. For polar areas in midnight sun and polar night periods this parameter is not returned in the response
  final int sunset;

  /// The time of when the moon rises for this day, Unix, UTC
  final int moonrise;

  /// The time of when the moon sets for this day, Unix, UTC
  final int moonset;

  /// Moon phase. 0 and 1 are 'new moon', 0.25 is 'first quarter moon', 0.5 is 'full moon' and 0.75 is 'last quarter moon'. The periods in between are called 'waxing crescent', 'waxing gibbous', 'waning gibbous', and 'waning crescent', respectively. Moon phase calculation algorithm: if the moon phase values between the start of the day and the end of the day have a round value (0, 0.25, 0.5, 0.75, 1.0), then this round value is taken, otherwise the average of moon phases for the start of the day and the end of the day is taken
  final double moonPhase;

  /// Human-readable description of the weather conditions for the day
  final String summary;

  /// Units – default: kelvin, metric: Celsius, imperial: Fahrenheit. How to change units used [https://openweathermap.org/api/one-call-3#data]
  final WeatherForecastTempEntity temp;

  /// This accounts for the human perception of weather. Units – default: kelvin, metric: Celsius, imperial: Fahrenheit. How to change units used [https://openweathermap.org/api/one-call-3#data]
  final WeatherForecastFeelsLikeEntity feelsLike;

  /// Atmospheric pressure on the sea level, hPa
  final int pressure;

  /// Humidity, %
  final int humidity;

  /// Atmospheric temperature (varying according to pressure and humidity) below which water droplets begin to condense and dew can form. Units – default: kelvin, metric: Celsius, imperial: Fahrenheit.
  final double dewPoint;

  /// The maximum value of UV index for the day
  final double uvi;

  /// Probability of precipitation. The values of the parameter vary between 0 and 1, where 0 is equal to 0%, 1 is equal to 100%
  final double pop;

  /// (where available) Precipitation volume, mm. Please note that only mm as units of measurement are available for this parameter
  final double? rain;

  /// (where available) Snow volume, mm. Please note that only mm as units of measurement are available for this parameter
  final double? snow;

  /// Cloudiness, %
  final int clouds;

  /// Wind speed. Units – default: metre/sec, metric: metre/sec, imperial: miles/hour. How to change units used [https://openweathermap.org/api/one-call-3#data]
  final double windSpeed;

  /// Wind direction, degrees (meteorological)
  final int windDeg;

  /// (where available) Wind gust. Units – default: metre/sec, metric: metre/sec, imperial: miles/hour. How to change units used [https://openweathermap.org/api/one-call-3#data]
  final double? windGust;

  /// Weather
  final List<WeatherForecastWeatherEntity> weather;

  const WeatherForecastDailyEntity({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.weekday,
    required this.moonPhase,
    required this.summary,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.uvi,
    required this.pop,
    this.rain,
    this.snow,
    required this.clouds,
    required this.windSpeed,
    required this.windDeg,
    this.windGust,
    required this.weather,
  });

  @override
  List<Object?> get props {
    return [
      dt,
      sunrise,
      sunset,
      weekday,
      moonrise,
      moonset,
      moonPhase,
      summary,
      temp,
      feelsLike,
      pressure,
      humidity,
      dewPoint,
      uvi,
      pop,
      rain,
      snow,
      clouds,
      windSpeed,
      windDeg,
      windGust,
      weather,
    ];
  }
}
