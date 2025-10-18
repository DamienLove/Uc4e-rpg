import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/painting.dart';

import '../../util/colors.dart';

/// A simple circle that grows and fades in when a protocell forms.
class Protocell extends CircleComponent {
  Protocell(Vector2 at)
      : super(
          radius: 10,
          position: at,
          anchor: Anchor.center,
          paint: Paint()..color = UCColors.neonGreen,
        );

  /// Animate the protocell blooming: scale up and fade slightly.
  Future<void> bloom() async {
    // Expand quickly.
    add(ScaleEffect.to(
      Vector2.all(2.4),
      EffectController(duration: 0.8, curve: Curves.easeOut),
    ));
    // Wait for the scale effect to complete.
    await Future<void>.delayed(const Duration(milliseconds: 850));
    // Fade and settle.
    add(OpacityEffect.to(0.85, EffectController(duration: 0.6)));
    add(ScaleEffect.to(Vector2.all(2.0), EffectController(duration: 0.6)));
  }

  @override
  void render(Canvas c) {
    super.render(c);
    final ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = UCColors.neonTeal;
    c.drawCircle(Offset.zero, radius + 4, ring);
  }
}