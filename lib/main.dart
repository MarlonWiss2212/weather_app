import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/features/weather/presentation/pages/weather_page.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';
import 'package:weather_app/injection_container.dart';

void main() async {
  await Future.wait([
    initializeDependencies(),
    dotenv.load(fileName: ".local.env"),
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoWeather',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: SafeArea(
        child: ChangeNotifierProvider<WeatherProvider>(
          create: (_) => WeatherProvider(sl())..getWeather(),
          child: const WeatherPage(),
        ),
      ),
    );
  }
}
