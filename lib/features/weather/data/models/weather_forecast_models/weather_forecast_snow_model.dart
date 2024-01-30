import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_snow_entity.dart';

class WeatherForecastSnowModel extends WeatherForecastSnowEntity {
  const WeatherForecastSnowModel({
    super.oneHour,
  });

  /// Converts the [json] to the [WeatherForecastSnowModel]
  ///
  /// Throws an [ConvertingException] if the convertion did not work
  factory WeatherForecastSnowModel.fromJson(Map<String, dynamic> json) {
    try {
      return WeatherForecastSnowModel(
        oneHour: double.parse(json["1h"].toString()),
      );
    } on ConvertingException {
      rethrow;
    } catch (e) {
      throw ConvertingException();
    }
  }
}
