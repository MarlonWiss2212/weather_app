import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_daily_entity.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';
import 'package:weather_app/features/weather/presentation/widgets/general/weather_sunrise_sunset.dart';

class WeatherSunriseSunsetDailyPage extends StatelessWidget {
  final WeatherForecastDailyEntity? day;
  const WeatherSunriseSunsetDailyPage({
    super.key,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    final loading = context.select<WeatherProvider, bool>(
      (provider) => provider.loading,
    );
    final sunrise = (day?.sunrise ?? 0) * 1000; // * 1000 to make it unix
    final sunset = (day?.sunset ?? 0) * 1000; // * 1000 to make it unix
    final current = DateTime.now().millisecondsSinceEpoch;

    return WeatherSunriseSunset(
      sunrise: sunrise,
      sunset: sunset,
      loading: loading,
      percentage: current < sunrise ? 0 : null,
    );
  }
}
