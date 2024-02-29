import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_daily_entity.dart';
import 'package:weather_app/features/weather/presentation/widgets/general/failure_listener.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_daily_page/weather_humidity_daily_page.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_daily_page/weather_sunrise_sunset_daily_page.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_daily_page/weather_uv_index_daily_page.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_daily_page/weather_wind_daily_page.dart';

class WeatherDailyPage extends StatelessWidget {
  final WeatherForecastDailyEntity? day;

  const WeatherDailyPage({super.key, this.day});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        title: Text("Wetter${day != null ? " für ${day!.weekday}" : ""}"),
      ),
      body: FailureListener(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.only(top: 8),
                sliver: _gridOfBasicData(),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(top: 8),
                sliver: SliverToBoxAdapter(
                  child: WeatherSunriseSunsetDailyPage(day: day),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _gridOfBasicData() {
    return SliverGrid.count(
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      crossAxisCount: 2,
      childAspectRatio: 2.5,
      children: [
        WeatherUVIndexDailyPage(day: day),
        WeatherHumidityDailyPage(day: day),
        WeatherWindDailyPage(day: day),
      ],
    );
  }
}
