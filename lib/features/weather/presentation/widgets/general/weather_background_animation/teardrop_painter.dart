import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/presentation/widgets/general/weather_background_animation/teardrop_painter_widget.dart';

class TeardropPainter extends StatefulWidget {
  final double mmh;
  final double temp;

  const TeardropPainter({Key? key, required this.mmh, required this.temp})
      : super(key: key);

  @override
  State<TeardropPainter> createState() => _TeardropPainterState();
}

class _TeardropPainterState extends State<TeardropPainter> {
  late List<Offset> _drops;
  late Timer _timer;
  late int _numDrops;
  final double _dropSize = 14;
  final List<double> _fallSpeeds = [0.3, 0.4, 0.5, 0.6, 0.7];
  final Duration _updateInterval = const Duration(milliseconds: 50);
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    _numDrops = (widget.mmh * 25).toInt();
    _initializeDrops();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _initializeDrops() {
    _drops = List.generate(
      _numDrops,
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
    final List<Offset> drops = [];
    for (int i = 0; i < _drops.length; i++) {
      final Offset drop = _drops[i];
      final double fallSpeed = _fallSpeeds[i % 4];
      final double y =
          (drop.dy + fallSpeed * _updateInterval.inMilliseconds / 1000) % 1;
      drops.add(Offset(drop.dx, y));
    }
    setState(() => _drops = drops);
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TeardropPainterWidget(
        drops: _drops,
        mmh: widget.mmh,
        temp: widget.temp,
        dropSize: _dropSize,
      ),
    );
  }
}
