import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/presentation/widgets/general/weather_background_animation/teardrop_painter_widget.dart';

class TeardropPainter extends StatefulWidget {
  final double mmhRain;
  final double mmhSnow;
  final double temp;

  const TeardropPainter({
    Key? key,
    required this.mmhRain,
    required this.mmhSnow,
    required this.temp,
  }) : super(key: key);

  @override
  State<TeardropPainter> createState() => _TeardropPainterState();
}

class _TeardropPainterState extends State<TeardropPainter> {
  late List<Offset> _raindrops;
  late List<Offset> _snowflakes;
  late int _numraindrops;
  late int _numsnowflakes;
  final double _raindropAndSnowflakeSize = 14;

  late Timer _timer;
  final List<double> _fallSpeeds = [0.3, 0.4, 0.5, 0.6, 0.7];
  final Duration _updateInterval = const Duration(milliseconds: 20);
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    _numraindrops = (widget.mmhRain * 25).toInt();
    _numsnowflakes = (widget.mmhSnow * 25).toInt();
    _initializeDrops();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _initializeDrops() {
    _raindrops = List.generate(
      _numraindrops,
      (index) => Offset(
        random.nextDouble(),
        -random.nextDouble(),
      ),
    );
    _snowflakes = List.generate(
      _numsnowflakes,
      (index) => Offset(
        random.nextDouble(),
        -random.nextDouble(),
      ),
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(_updateInterval, _updateDrops);
  }

  void _updateDrops(Timer timer) {
    final List<Offset> raindrops = [];
    final List<Offset> snowflakes = [];
    for (int i = 0; i < _raindrops.length; i++) {
      final Offset drop = _raindrops[i];
      final double fallSpeed = _fallSpeeds[i % 4];
      final double y =
          (drop.dy + fallSpeed * _updateInterval.inMilliseconds / 1000) % 1;
      raindrops.add(Offset(drop.dx, y));
    }
    for (int i = 0; i < _snowflakes.length; i++) {
      final Offset drop = _snowflakes[i];
      final double fallSpeed = _fallSpeeds[i % 4];
      final double y =
          (drop.dy + fallSpeed * _updateInterval.inMilliseconds / 1000) % 1;
      snowflakes.add(Offset(drop.dx, y));
    }
    setState(() {
      _raindrops = raindrops;
      _snowflakes = snowflakes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TeardropPainterWidget(
        raindrops: _raindrops,
        snowflakes: _snowflakes,
        mmhRain: widget.mmhRain,
        mmhSnow: widget.mmhSnow,
        temp: widget.temp,
        raindropAndSnowflakeSize: _raindropAndSnowflakeSize,
      ),
    );
  }
}
