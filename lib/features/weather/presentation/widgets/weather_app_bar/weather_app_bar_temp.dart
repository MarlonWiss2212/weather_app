import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';

class WeatherAppBarTemp extends StatelessWidget {
  const WeatherAppBarTemp({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();

    return SliverAppBar(
      pinned: true,
      floating: true,
      backgroundColor: Colors.transparent,
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        expandedTitleScale: 1.0,
        title: Skeletonizer(
          enabled: provider.loading,
          child: Text(
            provider.weather != null
                ? "${provider.weather!.current.temp.round()}°"
                : "",
            style: Theme.of(context).textTheme.displayLarge?.apply(
                  color: Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}
