import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/config/routes/router.dart';
import 'package:weather_app/features/weather/presentation/provider/failure_provider.dart';
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
    final failureProvider = FailureProvider();
    return MaterialApp.router(
      themeMode: ThemeMode.light,
      scrollBehavior: const ScrollBehavior().copyWith(
        physics: const BouncingScrollPhysics(),
      ),
      title: 'GoWeather',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          background: const Color.fromARGB(255, 9, 121, 173),
          primary: Colors.white,
          brightness: Brightness.dark,
          secondary: const Color.fromARGB(255, 209, 209, 209),
          tertiary: const Color.fromARGB(255, 177, 177, 177),
        ),
        useMaterial3: true,
      ),
      routerConfig: router,
      builder: (context, child) => AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).colorScheme.background,
          systemNavigationBarColor: Theme.of(context).colorScheme.background,
        ),
        child: SafeArea(
          child: ChangeNotifierProvider<FailureProvider>(
            create: (_) => failureProvider,
            child: ChangeNotifierProvider<WeatherProvider>(
              create: (_) => WeatherProvider(
                sl(),
                failureProvider,
              )..getWeather(),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
