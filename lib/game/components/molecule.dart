import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

/// Types of molecules present in the primordial soup.
enum MoleculeType { H2, CH4, NH3, CO2, H2O }

/// A simple moving circle representing a molecule. Molecules bounce off the
/// edges of the scene and gently rotate, creating a lively backdrop.
class Molecule extends CircleComponent with HasGameRef {
  final MoleculeType kind;
  Vector2 velocity;
  final Paint _paint;
  static final _rng = Random();

  Molecule(this.kind, Vector2 position)
      : velocity = (Vector2.random(_rng) - Vector2.all(0.5))
          ..scale(40 + _rng.nextDouble() * 60),
        _paint = Paint()..color = _colorFor(kind),
        super(radius: 6, position: position, anchor: Anchor.center);

  /// Colour map for each molecule type.
  static Color _colorFor(MoleculeType k) {
    switch (k) {
      case MoleculeType.H2:
        return const Color(0xFF7DD3FC);
      case MoleculeType.CH4:
        return const Color(0xFFA7F3D0);
      case MoleculeType.NH3:
        return const Color(0xFFFDE68A);
      case MoleculeType.CO2:
        return const Color(0xFFFCA5A5);
      case MoleculeType.H2O:
        return const Color(0xFF93C5FD);
    }
  }

  /// Create a random molecule at a given position.
  static Molecule randomAt(Vector2 p) {
    final values = MoleculeType.values;
    return Molecule(values[_rng.nextInt(values.length)], p);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
    // Bounce off horizontal boundaries.
    if (position.x < 0 || position.x > game.size.x) velocity.x *= -1;
    // Bounce off vertical boundaries.
    if (position.y < 0 || position.y > game.size.y) velocity.y *= -1;
    // Add gentle rotation based on speed.
    angle += velocity.length * 0.0008 * dt;
  }

  @override
  void render(Canvas c) {
    c.drawCircle(Offset.zero, radius, _paint);
    // Outer glow ring.
    final glow = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = _paint.color.withOpacity(0.35);
    c.drawCircle(Offset.zero, radius + 2, glow);
  }
}