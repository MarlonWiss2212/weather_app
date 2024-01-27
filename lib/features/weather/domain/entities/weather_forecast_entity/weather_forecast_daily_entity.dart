import 'package:equatable/equatable.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_feels_like_entity.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_temp_entity.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_weather_entity.dart';

class WeatherForecastDailyEntity extends Equatable {
  final int dt;
  final int sunrise;
  final int sunset;
  final int moonrise;
  final int moonset;
  final double moonPhase;
  final String sumary;
  final WeatherForecastTempEntity temp;
  final WeatherForecastFeelsLikeEntity feelsLike;
  final int pressure;
  final int humidity;
  final double dewPoint;
  final double uvi;
  final double pop;
  final double rain;
  final int clouds;
  final double windSpeed;
  final double windDeg;
  final double windGust;
  final List<WeatherForecastWeatherEntity> weather;

  const WeatherForecastDailyEntity({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    required this.sumary,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.uvi,
    required this.pop,
    required this.rain,
    required this.clouds,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.weather,
  });

  @override
  List<Object?> get props {
    return [
      dt,
      sunrise,
      sunset,
      moonrise,
      moonset,
      moonPhase,
      sumary,
      temp,
      feelsLike,
      pressure,
      humidity,
      dewPoint,
      uvi,
      pop,
      rain,
      clouds,
      windSpeed,
      windDeg,
      windGust,
      weather,
    ];
  }
}
