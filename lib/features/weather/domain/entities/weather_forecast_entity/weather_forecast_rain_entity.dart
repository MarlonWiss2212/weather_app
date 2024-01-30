import 'package:equatable/equatable.dart';

/// Rain
class WeatherForecastRainEntity extends Equatable {
  /// (where available) Precipitation, mm/h. Please note that only mm/h as units of measurement are available for this parameter
  final double? oneHour;

  const WeatherForecastRainEntity({
    this.oneHour,
  });

  @override
  List<Object?> get props {
    return [
      oneHour,
    ];
  }
}
