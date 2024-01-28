import 'package:dio/dio.dart';
import 'package:weather_app/core/constants/constants.dart';
import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_entity.dart';

abstract class WeatherService {
  Future<DataState<WeatherForecastEntity>> getWeatherData();
}

class WeatherServiceImpl implements WeatherService {
  final Dio dio;

  WeatherServiceImpl({required this.dio});

  @override
  Future<DataState<WeatherForecastEntity>> getWeatherData() async {
    await dio.get(apiBaseUrl);
    throw new UnimplementedError();
  }
}
