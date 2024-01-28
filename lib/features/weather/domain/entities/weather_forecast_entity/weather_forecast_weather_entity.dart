import 'package:equatable/equatable.dart';

/// Weather
class WeatherForecastWeatherEntity extends Equatable {
  /// Weather condition id [https://openweathermap.org/weather-conditions#Weather-Condition-Codes-2]
  final int id;

  /// Group of weather parameters (Rain, Snow etc.)
  final String main;

  /// Weather condition within the group (full list of weather conditions[https://openweathermap.org/weather-conditions#Weather-Condition-Codes-2]). Get the output in your language [https://openweathermap.org/api/one-call-3#multi]
  final String description;

  /// Weather icon id. How to get icons [https://openweathermap.org/weather-conditions#How-to-get-icon-URL]
  final String icon;

  const WeatherForecastWeatherEntity({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  @override
  List<Object?> get props => [id, main, description, icon];
}
