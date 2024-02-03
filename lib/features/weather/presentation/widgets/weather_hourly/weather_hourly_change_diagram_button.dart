import 'package:flutter/material.dart';

class WeatherHourlyChangeDiagramButton extends StatelessWidget {
  final void Function(bool) onChanged;
  final bool value;

  const WeatherHourlyChangeDiagramButton({
    super.key,
    required this.onChanged,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: RadioListTile(
            contentPadding: const EdgeInsets.all(0),
            title: const Text("Regen Diagram"),
            dense: true,
            value: true,
            groupValue: value,
            onChanged: (newValue) {
              if (newValue != null) {
                onChanged(newValue);
              }
            },
          ),
        ),
        Flexible(
          child: RadioListTile(
            contentPadding: const EdgeInsets.all(0),
            title: const Text("Temperatur Diagram"),
            dense: true,
            value: false,
            groupValue: value,
            onChanged: (newValue) {
              if (newValue != null) {
                onChanged(newValue);
              }
            },
          ),
        ),
      ],
    );
  }
}
