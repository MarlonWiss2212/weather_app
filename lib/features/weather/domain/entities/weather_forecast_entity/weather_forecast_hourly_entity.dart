import 'package:equatable/equatable.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_weather_entity.dart';

class WeatherForecastHourlyEntity extends Equatable {
  final int dt;
  final double temp;
  final double feelsLike;
  final int pressure;
  final int humidity;
  final double dewPoint;
  final double uvi;
  final int clouds;
  final int visibility;
  final double windSpeed;
  final double windDeg;
  final double windGust;
  final List<WeatherForecastWeatherEntity> weather;
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
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.weather,
    required this.pop,
  });

  @override
  List<Object?> get props {
    return [
      dt,
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
      pop,
    ];
  }
}
