import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';
import 'package:weather_app/features/weather/presentation/widgets/general/weather_sunrise_sunset.dart';

class WeatherSunriseSunsetWeatherPage extends StatelessWidget {
  const WeatherSunriseSunsetWeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sunrise = context.select<WeatherProvider, int?>(
      (provider) => provider.weather != null
          ? provider.weather!.current.sunrise * 1000
          : null, // * 1000 to make it unix
    );
    final sunset = context.select<WeatherProvider, int?>(
      (provider) => provider.weather != null
          ? provider.weather!.current.sunset * 1000
          : null, // * 1000 to make it unix
    );
    final loading = context.select<WeatherProvider, bool>(
      (provider) => provider.loading,
    );
    return WeatherSunriseSunset(
      sunrise: sunrise,
      sunset: sunset,
      loading: loading,
    );
  }
}
