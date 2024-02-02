import 'package:equatable/equatable.dart';

/// Minute forecast weather data API response
class WeatherForecastMinutlyEntity extends Equatable {
  /// Time of the forecasted data, unix, UTC
  final int dt;

  /// Precipitation, mm/h. Please note that only mm/h as units of measurement are available for this parameter
  final double precipitation;

  const WeatherForecastMinutlyEntity({
    required this.dt,
    required this.precipitation,
  });

  @override
  List<Object?> get props {
    return [
      dt,
      precipitation,
    ];
  }
}
