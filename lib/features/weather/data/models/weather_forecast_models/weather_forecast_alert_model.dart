import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_alert_entity.dart';

class WeatherForecastAlertModel extends WeatherForecastAlertEntity {
  const WeatherForecastAlertModel({
    required super.senderName,
    required super.event,
    required super.start,
    required super.end,
    required super.description,
    required super.tags,
  });

  /// Converts the [json] to the [WeatherForecastAlertsModel]
  ///
  /// Throws an [ConvertingException] if the convertion did not work
  factory WeatherForecastAlertModel.fromJson(Map<String, dynamic> json) {
    try {
      final List<String> tags = [];
      for (final tag in json["tags"]) {
        tags.add(tag);
      }

      return WeatherForecastAlertModel(
        senderName: json["sender_name"],
        event: json["event"],
        start: json["start"],
        end: json["end"],
        description: json["description"],
        tags: tags,
      );
    } on ConvertingException {
      rethrow;
    } catch (e) {
      throw ConvertingException();
    }
  }
}
