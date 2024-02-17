import 'package:flutter/material.dart';

class UvUtils {
  static String uvIndex(double uvi) => switch (uvi) {
        > 11 => "Extrem",
        > 8 && < 11 => "Sehr hoch",
        > 6 && < 8 => "Hoch",
        > 3 && < 6 => "Mäßig",
        < 3 => "Niedrig",
        _ => "K.A."
      };

  static Color colorByUvIndex(double uvi) => switch (uvi) {
        < 1 => const Color.fromARGB(255, 0, 223, 11),
        < 2 => const Color.fromARGB(255, 71, 223, 0),
        < 3 => const Color.fromARGB(255, 175, 223, 0),
        < 4 => const Color.fromARGB(255, 201, 223, 0),
        < 5 => const Color.fromARGB(255, 223, 201, 0),
        < 6 => const Color.fromARGB(255, 223, 145, 0),
        < 7 => const Color.fromARGB(255, 223, 89, 0),
        < 8 => const Color.fromARGB(255, 223, 33, 0),
        < 9 => const Color.fromARGB(255, 223, 0, 0),
        < 10 => const Color.fromARGB(255, 161, 0, 0),
        > 10 => const Color.fromARGB(255, 112, 0, 0),
        _ => const Color.fromARGB(0, 0, 0, 0),
      };
}
