import 'package:equatable/equatable.dart';

/// National weather alerts data from major national weather warning systems
class WeatherForecastAlertsEntity extends Equatable {
  /// Name of the alert source. Please read here the full list of alerts sources [https://openweathermap.org/api/one-call-3#listsource]
  final String senderName;

  /// Alert event name
  final String event;

  /// Date and time of the start of the alert, Unix, UTC
  final int start;

  /// Date and time of the end of the alert, Unix, UTC
  final int end;

  /// Description of the alert
  final String description;

  /// Type of severe weather
  final List<dynamic> tags;

  const WeatherForecastAlertsEntity({
    required this.senderName,
    required this.event,
    required this.start,
    required this.end,
    required this.description,
    required this.tags,
  });

  @override
  List<Object?> get props {
    return [
      senderName,
      event,
      start,
      end,
      description,
      tags,
    ];
  }
}
