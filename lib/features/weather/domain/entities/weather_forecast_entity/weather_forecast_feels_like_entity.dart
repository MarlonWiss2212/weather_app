import 'package:equatable/equatable.dart';

/// This accounts for the human perception of weather. Units – default: kelvin, metric: Celsius, imperial: Fahrenheit. How to change units used [https://openweathermap.org/api/one-call-3#data]
class WeatherForecastFeelsLikeEntity extends Equatable {
  /// Morning temperature.
  final double day;

  /// Day temperature.
  final double night;

  /// Evening temperature.
  final double eve;

  /// Night temperature.
  final double morn;

  const WeatherForecastFeelsLikeEntity({
    required this.day,
    required this.night,
    required this.eve,
    required this.morn,
  });

  @override
  List<Object?> get props => [day, night, eve, morn];
}
