import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconUtils {
  static IconData getIconByWeatherMapIconCode(
    String iconCode, {
    bool snow = false,
  }) =>
      switch (iconCode) {
        "01d" => CupertinoIcons.sun_max_fill,
        "01n" => CupertinoIcons.moon_fill,
        "02d" => CupertinoIcons.cloud_sun_fill,
        "02n" => CupertinoIcons.cloud_moon_fill,
        "03d" || "04d" || "03n" || "04n" => CupertinoIcons.cloud_fill,
        "09d" || "09n" => snow
            ? CupertinoIcons.cloud_snow_fill
            : CupertinoIcons.cloud_rain_fill,
        "10d" || "10n" => snow
            //TODO: Cloud_sun_snow_fill in future
            ? CupertinoIcons.cloud_snow_fill
            : iconCode == "10d"
                ? CupertinoIcons.cloud_sun_rain_fill
                : CupertinoIcons.cloud_moon_rain_fill,
        "11d" || "11n" => CupertinoIcons.cloud_bolt_fill,
        "13d" || "13n" => CupertinoIcons.cloud_snow_fill,
        "50d" || "50n" => CupertinoIcons.cloud_fog_fill,
        _ => Icons.abc,
      };
}
