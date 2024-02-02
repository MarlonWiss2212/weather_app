import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_app_bar/weather_app_bar.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_daily_data.dart';

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
          child: CustomScrollView(
            slivers: [
              const WeatherAppBar(),
              const SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                sliver: SliverToBoxAdapter(
                  child: WeatherDailyData(),
                ),
              ),
              SliverGrid.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                childAspectRatio: 1,
                children: const [
                  WeatherDailyData(),
                  WeatherDailyData(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
