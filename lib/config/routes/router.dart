import 'package:go_router/go_router.dart';
import 'package:weather_app/features/weather/presentation/pages/weather_map_page.dart';
import 'package:weather_app/features/weather/presentation/pages/weather_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (_, __) => const WeatherPage(),
    ),
    GoRoute(
      path: "/map",
      builder: (_, __) => const WeatherMapPage(),
    ),
  ],
);
