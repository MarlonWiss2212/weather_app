import 'dart:math';

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';

abstract class WeatherAppBarBaseDelegate
    extends SliverPersistentHeaderDelegate {
  Widget child(BuildContext context, double progress);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final progress = minExtent / shrinkOffset;
    return Blur(
      overlay: Padding(
        padding: const EdgeInsets.all(8),
        child: child(context, progress),
      ),
      borderRadius: BorderRadius.circular(8),
      alignment: Alignment.centerLeft,
      blurColor: Colors.black,
      colorOpacity: min(max(0, ((shrinkOffset / minExtent) - 0.2) / 3), .15),
      blur: 10 - progress * 10,
      child: const SizedBox.expand(),
    );
  }

  @override
  double get maxExtent => 230;

  @override
  double get minExtent => 120;

  @override
  bool shouldRebuild(oldDelegate) => true;
}
