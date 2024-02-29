import 'package:go_router/go_router.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_daily_entity.dart';
import 'package:weather_app/features/weather/presentation/pages/weather_daily_page.dart';
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
    GoRoute(
      path: "/daily",
      builder: (_, state) {
        final day = state.extra as WeatherForecastDailyEntity?;
        return WeatherDailyPage(day: day);
      },
    ),
  ],
);
