import 'package:equatable/equatable.dart';

class WeatherForecastTempEntity extends Equatable {
  final double day;
  final double min;
  final double max;
  final double night;
  final double eve;
  final double morn;

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
