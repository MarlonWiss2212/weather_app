import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_app_bar/weather_app_bar.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_daily/weather_daily.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_hourly/weather_hourly.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_hourly_chart/weather_hourly_chart.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 158, 226),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: RefreshIndicator(
          color: Theme.of(context).colorScheme.primary,
          backgroundColor: Colors.black,
          onRefresh: () async {
            return await Provider.of<WeatherProvider>(
              context,
              listen: false,
            ).getWeather();
          },
          child: const CustomScrollView(
            slivers: [
              WeatherAppBar(),
              SliverPadding(
                padding: EdgeInsets.only(top: 8),
                sliver: SliverToBoxAdapter(
                  child: WeatherHourly(),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(top: 8),
                sliver: SliverToBoxAdapter(
                  child: WeatherHourlyChart(),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 8),
                sliver: SliverToBoxAdapter(
                  child: WeatherDaily(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
