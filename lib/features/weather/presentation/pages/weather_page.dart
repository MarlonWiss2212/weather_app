import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/features/weather/presentation/provider/failure_provider.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';
import 'package:weather_app/features/weather/presentation/widgets/general/failure_listener.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_map/weather_map_box.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page/weather_alerts/weather_alerts.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page/weather_app_bar/weather_app_bar.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page/weather_daily/weather_daily.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page/weather_hourly/weather_hourly.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page/weather_hourly_chart/weather_hourly_chart.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page/weather_humidity_weather_page.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page/weather_sunrise_sunset.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page/weather_uv_index_weather_page.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page/weather_visibility_weather_page.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page/weather_wind_weather_page.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  void listenToFailuresAndAddScaffold(BuildContext context) {
    Provider.of<FailureProvider>(context, listen: true).addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FailureListener(
        child: Padding(
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
                  padding: const EdgeInsets.only(top: 8),
                  sliver: _gridOfBasicData(),
                ),
                const SliverPadding(
                  padding: EdgeInsets.only(top: 8),
                  sliver: SliverToBoxAdapter(
                    child: WeatherSunriseSunset(),
                  ),
                ),
                const SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  sliver: SliverToBoxAdapter(
                    child: WeatherMapBox(),
                  ),
                ),
              ],
            ),
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
        WeatherUVIndexWeatherPage(),
        WeatherHumidityWeatherPage(),
        WeatherVisibilityWeatherPage(),
        WeatherWindWeatherPage(),
      ],
    );
  }
}
