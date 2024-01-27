import 'package:equatable/equatable.dart';

/// Snow
class WeatherForecastSnowEntity extends Equatable {
  ///(where available) Precipitation, mm/h. Please note that only mm/h as units of measurement are available for this parameter
  final dynamic? oneHour;

  const WeatherForecastSnowEntity({
    this.oneHour,
  });

  @override
  List<Object?> get props {
    return [
      oneHour,
    ];
  }
}
