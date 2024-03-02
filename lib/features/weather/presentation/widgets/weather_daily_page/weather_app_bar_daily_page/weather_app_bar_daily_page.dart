import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_daily_entity.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_daily_page/weather_app_bar_daily_page/weather_app_bar_delegate_daily_page.dart';

class WeatherAppBarDailyPage extends StatelessWidget {
  final WeatherForecastDailyEntity? day;
  const WeatherAppBarDailyPage({super.key, this.day});

  @override
  Widget build(BuildContext context) {
    final loading = context.select<WeatherProvider, bool>(
      (value) => value.loading,
    );

    return SliverPersistentHeader(
      pinned: true,
      delegate: WeatherAppBarDelegateDailyPage(
        day: day,
        loading: loading,
      ),
    );
  }
}
