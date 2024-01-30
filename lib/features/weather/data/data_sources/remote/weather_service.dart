import 'package:dio/dio.dart';
import 'package:weather_app/core/constants/constants.dart';
import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/core/params/get_weather_params.dart';
import 'package:weather_app/features/weather/data/models/weather_forecast_models/weather_forecast_model.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_entity.dart';

abstract class WeatherService {
  Future<WeatherForecastEntity> getWeatherData({
    required GetWeatherParams params,
  });
}

class WeatherServiceImpl implements WeatherService {
  final Dio dio;

  WeatherServiceImpl({required this.dio});

  @override
  Future<WeatherForecastEntity> getWeatherData({
    required GetWeatherParams params,
  }) async {
    final response = await dio.get(
      "$apiBaseUrl/data/3.0/onecall",
      queryParameters: params.toMap(),
      options: Options(method: "GET"),
    );

    if (response.data != null) {
      return WeatherForecastModel.fromJSON(response.data);
    }
    throw NoAPIResponseException();
  }
}
