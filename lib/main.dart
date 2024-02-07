import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/features/weather/presentation/pages/weather_page.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';
import 'package:weather_app/injection_container.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await Future.wait([
    initializeDependencies(),
    dotenv.load(fileName: ".local.env"),
    initializeDateFormatting()
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      title: 'GoWeather',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          background: const Color.fromARGB(255, 46, 161, 255),
          primary: Colors.white,
          brightness: Brightness.dark,
          secondary: const Color.fromARGB(255, 209, 209, 209),
          tertiary: const Color.fromARGB(255, 177, 177, 177),
        ),
        useMaterial3: true,
      ),
      home: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: Color.fromARGB(255, 46, 161, 255),
          systemNavigationBarColor: Color.fromARGB(255, 46, 161, 255),
        ),
        child: SafeArea(
          child: ChangeNotifierProvider<WeatherProvider>(
            create: (_) => WeatherProvider(sl())..getWeather(),
            child: const WeatherPage(),
          ),
        ),
      ),
    );
  }
}
