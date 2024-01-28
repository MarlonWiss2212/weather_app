import 'package:dio/dio.dart';
import 'package:weather_app/core/constants/constants.dart';
import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/core/params/params.dart';
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
      apiBaseUrl,
      queryParameters: params.toMap(),
    );

    if (response.data != null) {
      /// TODO: implement
    }
    throw NoAPIResponseException();
  }
}
