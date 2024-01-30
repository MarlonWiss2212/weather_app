import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/core/params/get_weather_params.dart';
import 'package:weather_app/features/weather/data/data_sources/local/location_service.dart';
import 'package:weather_app/features/weather/data/data_sources/remote/weather_service.dart';
import 'package:weather_app/features/weather/data/repository/location_repository_impl.dart';
import 'package:weather_app/features/weather/data/repository/weather_repository_impl.dart';
import 'package:weather_app/features/weather/domain/usecases/location/get_location.dart';
import 'package:weather_app/features/weather/domain/usecases/weather/get_weather_by_location.dart';

void main() async {
  // load env
  await dotenv.load(fileName: ".local.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoWeather',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("GoWeather"),
      ),
      body: FutureBuilder(
        future: GetWeatherByLocationUseCase(
          weatherRepository: WeatherRepositoryImpl(
            weatherService: WeatherServiceImpl(
              dio: Dio(),
            ),
          ),
          getLocationUseCase: GetLocationUseCase(
            locationRepository: LocationRepositoryImpl(
              locationService: LocationServiceImpl(),
            ),
          ),
        ).call(
          params: GetWeatherParams(
            appid: dotenv.get("OPEN_WEATHER_APP_ID"),
          ),
        ),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.data?.failure != null) {
            return Text(snapshot.data!.failure!.errorMessage);
          }
          if (snapshot.data?.data != null) {
            return Text(snapshot.data!.data!.current.temp.toString());
          }
          if (snapshot.hasError) {
            return Text(snapshot.error!.toString());
          }
          return const Text("UNKOWN");
        },
      ),
    );
  }
}
