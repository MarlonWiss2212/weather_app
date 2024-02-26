import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/core/params/get_weather_params.dart';
import 'package:weather_app/core/util/enums/map_type_enum.dart';
import 'package:weather_app/features/weather/domain/entities/geocoding/reverse_geocoding_entity.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_entity.dart';
import 'package:weather_app/features/weather/domain/usecases/weather/get_weather_by_location.dart';
import 'package:weather_app/features/weather/presentation/provider/failure_provider.dart';

/// Provides state and functions for the weather data
class WeatherProvider extends ChangeNotifier {
  final GetWeatherByLocationUseCase _getWeatherByLocationUseCase;
  final FailureProvider _failureProvider;

  WeatherForecastEntity? _weather;
  ReverseGeocodingEntity? _geodata;
  MapType _activeMapType = MapType.temp;
  bool _loading = false;

  WeatherProvider(
    this._getWeatherByLocationUseCase,
    this._failureProvider,
  );

  MapType get activeMapType {
    return _activeMapType;
  }

  void setActiveMapType(MapType value) {
    _activeMapType = value;
    notifyListeners();
  }

  bool get loading {
    return _loading;
  }

  WeatherForecastEntity? get weather {
    return _weather;
  }

  ReverseGeocodingEntity? get geodata {
    return _geodata;
  }

  /// Represents the function responsible for retrieving weather data.
  Future<void> getWeather() async {
    _loading = true;
    notifyListeners();

    final weatherOrFailure = await _getWeatherByLocationUseCase.call(
      params: GetWeatherParams(
        appid: dotenv.get("OPEN_WEATHER_APP_ID"),
        units: "metric",
        exclude: "minutely",
        lang: Platform.localeName.split("_")[0],
      ),
    );

    weatherOrFailure.either<void>(
      onSuccess: (data) {
        _weather = data.$1;
        _geodata = data.$2;
      },
      onError: (failure) {
        _failureProvider.addFailureToList(failure);
      },
    );

    _failureProvider.addFailureToList(NoAPIResponseFailure());

    _loading = false;
    notifyListeners();
  }
}
