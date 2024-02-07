import 'package:dio/dio.dart';
import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/core/params/get_weather_with_location_params.dart';
import 'package:weather_app/core/params/reverse_geocoding_params.dart';
import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/features/weather/data/data_sources/remote/geocoding_service.dart';
import 'package:weather_app/features/weather/data/data_sources/remote/weather_service.dart';
import 'package:weather_app/features/weather/data/models/geocoding_models/reverse_geocoding_model.dart';
import 'package:weather_app/features/weather/data/models/weather_forecast_models/weather_forecast_model.dart';
import 'package:weather_app/features/weather/domain/repository/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherService weatherService;
  final GeocodingService geocodingService;

  WeatherRepositoryImpl({
    required this.weatherService,
    required this.geocodingService,
  });

  @override
  Future<DataState<(WeatherForecastModel, ReverseGeocodingModel?)>>
      getWeatherData({
    required GetWeatherWithLocationParams params,
  }) async {
    WeatherForecastModel? weatherData;
    try {
      weatherData = await weatherService.getWeatherData(params: params);
      final geoData = await geocodingService.reverseGeocoding(
        params: ReverseGeocodingParams(
          lat: params.lat,
          lon: params.lon,
          appid: params.appid,
        ),
      );
      return DataState.success((weatherData, geoData));
    } on NoAPIResponseException {
      return DataState.failure(
        const NoAPIResponseFailure(),
        data: weatherData != null ? (weatherData, null) : null,
      );
    } on ConvertingException {
      return DataState.failure(
        const ConvertingFailure(),
        data: weatherData != null ? (weatherData, null) : null,
      );
    } on DioException catch (e) {
      return DataState.failure(
        ServerFailure(error: e),
        data: weatherData != null ? (weatherData, null) : null,
      );
    } catch (e) {
      return DataState.failure(
        const UnkownFailure(),
        data: weatherData != null ? (weatherData, null) : null,
      );
    }
  }
}
