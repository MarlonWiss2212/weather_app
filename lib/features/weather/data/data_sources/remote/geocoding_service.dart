import 'package:dio/dio.dart';
import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/core/params/reverse_geocoding_params.dart';
import 'package:weather_app/features/weather/data/models/geocoding_models/reverse_geocoding_model.dart';

abstract class GeocodingService {
  Future<ReverseGeocodingModel> reverseGeocoding({
    required ReverseGeocodingParams params,
  });
}

class GeocodingServiceImpl extends GeocodingService {
  final Dio dio;

  GeocodingServiceImpl({
    required this.dio,
  });

  @override
  Future<ReverseGeocodingModel> reverseGeocoding({
    required ReverseGeocodingParams params,
  }) async {
    final response = await dio.get<Map<String, dynamic>>(
      "geo/1.0/reverse",
      queryParameters: {
        ...params.toMap(),
        "limit": 1,
      },
      options: Options(method: "GET"),
    );

    if (response.data != null) {
      return ReverseGeocodingModel.fromJson(response.data![0]);
    }
    throw NoAPIResponseException();
  }
}
