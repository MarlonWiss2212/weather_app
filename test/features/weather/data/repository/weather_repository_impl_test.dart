import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/core/params/get_weather_with_location_params.dart';
import 'package:weather_app/core/params/reverse_geocoding_params.dart';
import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/features/weather/data/data_sources/remote/geocoding_service.dart';
import 'package:weather_app/features/weather/data/data_sources/remote/weather_service.dart';
import 'package:weather_app/features/weather/data/models/geocoding_models/reverse_geocoding_model.dart';
import 'package:weather_app/features/weather/data/models/weather_forecast_models/weather_forecast_model.dart';
import 'package:weather_app/features/weather/data/repository/weather_repository_impl.dart';
import 'weather_repository_impl_test.mocks.dart';

@GenerateMocks([WeatherServiceImpl, GeocodingServiceImpl])
void main() {
  final MockWeatherServiceImpl mockWeatherService = MockWeatherServiceImpl();
  final MockGeocodingServiceImpl mockGeocodingService =
      MockGeocodingServiceImpl();

  final WeatherRepositoryImpl repository = WeatherRepositoryImpl(
    weatherService: mockWeatherService,
    geocodingService: mockGeocodingService,
  );

  group("getWeatherData function tests", () {
    // models
    final WeatherForecastModel model = WeatherForecastModel.fromJSON({
      "lat": 33.44,
      "lon": -94.04,
      "timezone": "America/Chicago",
      "timezone_offset": -18000,
      "current": {
        "dt": 1684929490,
        "sunrise": 1684926645,
        "sunset": 1684977332,
        "temp": 292.55,
        "feels_like": 292.87,
        "pressure": 1014,
        "humidity": 89,
        "dew_point": 290.69,
        "uvi": 0.16,
        "clouds": 53,
        "visibility": 10000,
        "wind_speed": 3.13,
        "wind_deg": 93,
        "wind_gust": 6.71,
        "weather": [
          {
            "id": 803,
            "main": "Clouds",
            "description": "broken clouds",
            "icon": "04d"
          }
        ]
      },
      "minutely": [
        {"dt": 1684929540, "precipitation": 0},
      ],
      "hourly": [
        {
          "dt": 1684926000,
          "temp": 292.01,
          "feels_like": 292.33,
          "pressure": 1014,
          "humidity": 91,
          "dew_point": 290.51,
          "uvi": 0,
          "clouds": 54,
          "visibility": 10000,
          "wind_speed": 2.58,
          "wind_deg": 86,
          "wind_gust": 5.88,
          "weather": [
            {
              "id": 803,
              "main": "Clouds",
              "description": "broken clouds",
              "icon": "04n"
            }
          ],
          "pop": 0.15
        },
      ],
      "daily": [
        {
          "dt": 1684951200,
          "sunrise": 1684926645,
          "sunset": 1684977332,
          "moonrise": 1684941060,
          "moonset": 1684905480,
          "moon_phase": 0.16,
          "summary": "Expect a day of partly cloudy with rain",
          "temp": {
            "day": 299.03,
            "min": 290.69,
            "max": 300.35,
            "night": 291.45,
            "eve": 297.51,
            "morn": 292.55
          },
          "feels_like": {
            "day": 299.21,
            "night": 291.37,
            "eve": 297.86,
            "morn": 292.87
          },
          "pressure": 1016,
          "humidity": 59,
          "dew_point": 290.48,
          "wind_speed": 3.98,
          "wind_deg": 76,
          "wind_gust": 8.92,
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10d"
            }
          ],
          "clouds": 92,
          "pop": 0.47,
          "rain": 0.15,
          "uvi": 9.23
        },
      ],
      "alerts": [
        {
          "sender_name":
              "NWS Philadelphia - Mount Holly (New Jersey, Delaware, Southeastern Pennsylvania)",
          "event": "Small Craft Advisory",
          "start": 1684952747,
          "end": 1684988747,
          "description":
              "...SMALL CRAFT ADVISORY REMAINS IN EFFECT FROM 5 PM THIS\nAFTERNOON TO 3 AM EST FRIDAY...\n* WHAT...North winds 15 to 20 kt with gusts up to 25 kt and seas\n3 to 5 ft expected.\n* WHERE...Coastal waters from Little Egg Inlet to Great Egg\nInlet NJ out 20 nm, Coastal waters from Great Egg Inlet to\nCape May NJ out 20 nm and Coastal waters from Manasquan Inlet\nto Little Egg Inlet NJ out 20 nm.\n* WHEN...From 5 PM this afternoon to 3 AM EST Friday.\n* IMPACTS...Conditions will be hazardous to small craft.",
          "tags": []
        },
      ]
    });
    final ReverseGeocodingModel modelGeo = ReverseGeocodingModel.fromJson(
      const {
        "name": "London",
        "local_names": {
          "af": "Londen",
          "ar": "لندن",
          "ascii": "London",
          "az": "London",
          "bg": "Лондон",
          "ca": "Londres",
          "da": "London",
          "de": "London",
          "el": "Λονδίνο",
          "en": "London",
          "eu": "Londres",
          "fa": "لندن",
          "feature_name": "London",
          "fi": "Lontoo",
          "fr": "Londres",
          "gl": "Londres",
          "he": "לונדון",
          "hi": "लंदन",
          "hr": "London",
          "hu": "London",
          "id": "London",
          "it": "Londra",
          "ja": "ロンドン",
          "la": "Londinium",
          "lt": "Londonas",
          "mk": "Лондон",
          "nl": "Londen",
          "no": "London",
          "pl": "Londyn",
          "pt": "Londres",
          "ro": "Londra",
          "ru": "Лондон",
          "sk": "Londýn",
          "sl": "London",
          "sr": "Лондон",
          "th": "ลอนดอน",
          "tr": "Londra",
          "vi": "Luân Đôn",
          "zu": "ILondon"
        },
        "lat": 51.5085,
        "lon": -0.1257,
        "country": "GB"
      },
    );

    test("should return both models if both services return their models",
        () async {
      // params
      const params = GetWeatherWithLocationParams(
        lat: 51.5085,
        lon: -0.1257,
        appid: "",
      );
      final paramsGeo = ReverseGeocodingParams.fromGetWeatherWithLocationParams(
        params: params,
      );

      // mocking
      when(
        mockWeatherService.getWeatherData(params: params),
      ).thenAnswer((_) async => model);
      when(
        mockGeocodingService.reverseGeocoding(params: paramsGeo),
      ).thenAnswer((_) async => modelGeo);

      // call function to test
      final response = await repository.getWeatherData(params: params);

      expect(
        response,
        DataState<(WeatherForecastModel, ReverseGeocodingModel?)>.success(
          (model, modelGeo),
        ),
      );
    });

    test(
        "should catch NoAPIResponseException from GeocodingService and return Failure as well as WeatherModel from the other WeatherService",
        () async {
      // params
      const params = GetWeatherWithLocationParams(
        lat: 51.5085,
        lon: -0.1257,
        appid: "",
      );
      final paramsGeo = ReverseGeocodingParams.fromGetWeatherWithLocationParams(
        params: params,
      );

      // mocking
      when(
        mockWeatherService.getWeatherData(params: params),
      ).thenAnswer((_) async => model);
      when(
        mockGeocodingService.reverseGeocoding(params: paramsGeo),
      ).thenThrow(NoAPIResponseException());

      // call function to test
      final response = await repository.getWeatherData(params: params);

      expect(
        response,
        DataState<(WeatherForecastModel, ReverseGeocodingModel?)>.failure(
          const NoAPIResponseFailure(),
          data: (model, null),
        ),
      );
    });

    test(
        "should return ConvertingFailure if either service throws ConvertingException",
        () async {
      const params = GetWeatherWithLocationParams(
        lat: 51.5085,
        lon: -0.1257,
        appid: "",
      );
      when(
        mockWeatherService.getWeatherData(params: params),
      ).thenThrow(ConvertingException());

      // call function to test
      final response = await repository.getWeatherData(params: params);

      expect(
        response,
        DataState<(WeatherForecastModel, ReverseGeocodingModel?)>.failure(
          const ConvertingFailure(),
        ),
      );
    });

    test(
        "should return ServerFailure if either service throws DioException exceptions",
        () async {
      final dioException = DioException(requestOptions: RequestOptions());

      // params
      const params = GetWeatherWithLocationParams(
        lat: 51.5085,
        lon: -0.1257,
        appid: "",
      );

      // mocking
      when(
        mockWeatherService.getWeatherData(params: params),
      ).thenThrow(dioException);

      // call function to test
      final response = await repository.getWeatherData(params: params);

      expect(
        response,
        DataState<(WeatherForecastModel, ReverseGeocodingModel?)>.failure(
          ServerFailure(error: dioException),
        ),
      );
    });

    test("should catch all exceptions", () async {
      const params = GetWeatherWithLocationParams(
        lat: 33.44,
        lon: 33.44,
        appid: "",
      );
      when(
        mockWeatherService.getWeatherData(params: params),
      ).thenThrow(Exception());

      // call function to test
      final response = await repository.getWeatherData(params: params);

      expect(
        response,
        DataState<(WeatherForecastModel, ReverseGeocodingModel?)>.failure(
          const UnkownFailure(),
        ),
      );
    });
  });
}
