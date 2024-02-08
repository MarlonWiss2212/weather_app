class UvUtils {
  static String uvIndex(double uvi) {
    return switch (uvi) {
      > 11 => "Extrem",
      > 8 && < 11 => "Sehr hoch",
      > 6 && < 8 => "Hoch",
      > 3 && < 6 => "Mäßig",
      < 3 => "Niedrig",
      _ => "K.A."
    };
  }
}
