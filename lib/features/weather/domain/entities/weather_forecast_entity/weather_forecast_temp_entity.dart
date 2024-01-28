import 'package:equatable/equatable.dart';

/// Units – default: kelvin, metric: Celsius, imperial: Fahrenheit. How to change units used [https://openweathermap.org/api/one-call-3#data]
class WeatherForecastTempEntity extends Equatable {
  /// Morning temperature.
  final double day;

  /// Day temperature.
  final double night;

  /// Evening temperature.
  final double eve;

  /// Night temperature.
  final double morn;

  /// Min daily temperature.
  final double min;

  /// Max daily temperature.
  final double max;

  const WeatherForecastTempEntity({
    required this.day,
    required this.night,
    required this.eve,
    required this.max,
    required this.min,
    required this.morn,
  });

  @override
  List<Object?> get props => [day, night, eve, morn, min, max];
}
