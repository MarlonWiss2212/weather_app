import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weather_app/features/weather/domain/entities/weather_forecast_entity/weather_forecast_alert_entity.dart';
import 'package:weather_app/features/weather/presentation/provider/weather_provider.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_alerts/weather_alert_box.dart';

class WeatherAlerts extends StatelessWidget {
  const WeatherAlerts({super.key});

  @override
  Widget build(BuildContext context) {
    final alerts =
        context.select<WeatherProvider, List<WeatherForecastAlertEntity>?>(
      (provider) => provider.weather?.alerts,
    );
    final loading = context.select<WeatherProvider, bool>(
      (provider) => provider.loading,
    );
    PageController controller = PageController();
    final showEmptyText = alerts == null || alerts.isEmpty;

    return Container(
      height: showEmptyText ? null : 120,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Skeletonizer(
        enabled: alerts == null && loading,
        child: showEmptyText
            ? const Center(child: Text("Keine Warnungen für Heute"))
            : Stack(
                children: [
                  PageView.builder(
                    controller: controller,
                    itemBuilder: (context, index) => WeatherAlertBox(
                      alert: alerts[index],
                    ),
                    itemCount: alerts.length,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    height: 20,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SmoothPageIndicator(
                        effect: WormEffect(
                          type: WormType.thin,
                          dotHeight: 10,
                          dotWidth: 10,
                          radius: 10,
                          activeDotColor: Theme.of(context).colorScheme.primary,
                          dotColor: Theme.of(context).colorScheme.secondary,
                        ),
                        controller: controller,
                        count: alerts.length,
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
