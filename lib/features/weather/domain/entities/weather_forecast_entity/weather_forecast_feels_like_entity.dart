import 'package:equatable/equatable.dart';

class WeatherForecastFeelsLikeEntity extends Equatable {
  final double day;
  final double night;
  final double eve;
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
