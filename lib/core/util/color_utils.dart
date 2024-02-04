import 'package:flutter/material.dart';

class ColorUtils {
  static Color colorByTemperatureLight(double? temperature) {
    if (temperature == null) {
      return Colors.grey;
    }
    return switch (temperature) {
      > 40 => const Color.fromARGB(255, 255, 30, 0),
      > 37 && < 40 => const Color.fromARGB(255, 255, 60, 15),
      > 34 && < 37 => const Color.fromARGB(255, 255, 90, 30),
      > 31 && < 34 => const Color.fromARGB(255, 255, 120, 45),
      > 28 && < 31 => const Color.fromARGB(255, 255, 150, 60),
      > 25 && < 28 => const Color.fromARGB(255, 255, 180, 90),
      > 22 && < 25 => const Color.fromARGB(255, 255, 210, 120),
      > 21 && < 22 => const Color.fromARGB(255, 255, 240, 150),
      > 20 && < 21 => const Color.fromARGB(255, 255, 240, 180),
      > 17 && < 20 => const Color.fromARGB(255, 255, 255, 210),
      > 14 && < 17 => const Color.fromARGB(255, 255, 255, 240),
      > 11 && < 14 => const Color.fromARGB(255, 210, 240, 255),
      > 8 && < 11 => const Color.fromARGB(255, 210, 240, 240),
      > 5 && < 8 => const Color.fromARGB(255, 165, 210, 230),
      > 2 && < 5 => const Color.fromARGB(255, 150, 210, 220),
      > -1 && < 2 => const Color.fromARGB(255, 120, 200, 210),
      > -4 && < -1 => const Color.fromARGB(255, 90, 170, 200),
      > -7 && < -4 => const Color.fromARGB(255, 60, 160, 190),
      > -10 && < -7 => const Color.fromARGB(255, 60, 160, 180),
      > -13 && < -10 => const Color.fromARGB(255, 60, 120, 170),
      > -13 => const Color.fromARGB(255, 60, 100, 160),
      _ => Colors.grey,
    };
  }
}
