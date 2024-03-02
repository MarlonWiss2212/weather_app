import 'package:intl/date_symbol_data_local.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/core/params/get_weather_params.dart';
import 'package:weather_app/core/params/get_weather_with_location_params.dart';
import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/features/weather/data/models/geocoding_models/reverse_geocoding_model.dart';
import 'package:weather_app/features/weather/data/models/weather_forecast_models/weather_forecast_model.dart';
import 'package:weather_app/features/weather/data/repository/weather_repository_impl.dart';
import 'package:weather_app/features/weather/domain/entities/geocoding/reverse_geocoding_entity.dart';
import 'package:weather_app/features/weather/domain/entities/location_entity.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_entity.dart';
import 'package:weather_app/features/weather/domain/usecases/location/get_location.dart';
import 'package:weather_app/features/weather/domain/usecases/weather/get_weather_by_location.dart';
import 'get_weather_by_location_test.mocks.dart';

@GenerateMocks([WeatherRepositoryImpl, GetLocationUseCase])
void main() {
  late MockWeatherRepositoryImpl mockLocationRepositoryImpl;
  late MockGetLocationUseCase mockGetLocationUseCase;
  late WeatherForecastModel model;

  setUp(() {
    initializeDateFormatting();
    mockGetLocationUseCase = MockGetLocationUseCase();
    mockLocationRepositoryImpl = MockWeatherRepositoryImpl();
    model = WeatherForecastModel.fromJSON({
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
  });

  group("test 'call' function", () {
    test("should return failure that 'getLocationUseCase.call' returns",
        () async {
      const Failure failure = UnkownFailure();
      const weatherParams = GetWeatherParams(appid: "");

      // mocking
      when(mockGetLocationUseCase.call()).thenAnswer(
        (_) async => DataState.failure(failure),
      );

      final result = await GetWeatherByLocationUseCase(
        getLocationUseCase: mockGetLocationUseCase,
        weatherRepository: mockLocationRepositoryImpl,
      ).call(params: weatherParams);

      expect(
        result,
        DataState<(WeatherForecastEntity, ReverseGeocodingEntity?)>.failure(
          failure,
        ),
      );
    });

    test(
        "should call and return same response as 'weatherRepository.getWeatherData' when location was returned previously",
        () async {
      final LocationEntity locationEntity = LocationEntity(
        longitude: 10,
        latitude: 10,
        timestamp: DateTime.now(),
        accuracy: 10,
        altitude: 10,
        altitudeAccuracy: 10,
        heading: 10,
        headingAccuracy: 10,
        speed: 10,
        speedAccuracy: 10,
      );
      const weatherParams = GetWeatherWithLocationParams(
        appid: "",
        lat: 10,
        lon: 10,
      );
      final DataState<(WeatherForecastModel, ReverseGeocodingModel?)>
          expectedResult = DataState.success((model, null));

      // mocking
      when(mockGetLocationUseCase.call()).thenAnswer(
        (_) async => DataState.success(locationEntity),
      );
      when(mockLocationRepositoryImpl.getWeatherData(params: weatherParams))
          .thenAnswer(
        (_) async => expectedResult,
      );

      final result = await GetWeatherByLocationUseCase(
        getLocationUseCase: mockGetLocationUseCase,
        weatherRepository: mockLocationRepositoryImpl,
      ).call(params: weatherParams);

      expect(result, expectedResult);
    });
  });
}
