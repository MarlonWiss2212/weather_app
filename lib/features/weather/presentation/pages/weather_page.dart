import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_alerts/weather_alerts.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_app_bar/weather_app_bar.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_daily/weather_daily.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_hourly/weather_hourly.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_hourly_chart/weather_hourly_chart.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_humidity.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_uv_index.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_visibility.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_wind.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: CustomScrollView(
            slivers: [
              const WeatherAppBar(),
              const SliverPadding(
                padding: EdgeInsets.only(top: 8),
                sliver: SliverToBoxAdapter(
                  child: WeatherAlerts(),
                ),
              ),
              const SliverPadding(
                padding: EdgeInsets.only(top: 8),
                sliver: SliverToBoxAdapter(
                  child: WeatherHourly(),
                ),
              ),
              const SliverPadding(
                padding: EdgeInsets.only(top: 8),
                sliver: SliverToBoxAdapter(
                  child: WeatherHourlyChart(),
                ),
              ),
              const SliverPadding(
                padding: EdgeInsets.only(top: 8),
                sliver: SliverToBoxAdapter(
                  child: WeatherDaily(),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                sliver: _gridOfBasicData(),
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
      children: const [
        WeatherUVIndex(),
        WeatherHumidity(),
        WeatherVisibility(),
        WeatherWind(),
      ],
    );
  }
}
