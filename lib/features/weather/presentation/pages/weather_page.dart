import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_app_bar/weather_app_bar.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_daily.dart';
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
      backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: RefreshIndicator(
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
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
                padding: EdgeInsets.symmetric(vertical: 10.0),
                sliver: SliverToBoxAdapter(
                  child: WeatherHourly(),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                sliver: SliverToBoxAdapter(
                  child: WeatherHourlyChart(),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
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
