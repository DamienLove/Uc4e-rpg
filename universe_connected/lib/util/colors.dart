import 'package:flutter/material.dart';

/// A simple palette of themed colours for the Universe Connected prototype.
///
/// Centralising colours makes it easier to tweak the look of the game later on
/// without hunting through the code for magic constants. These colours evoke
/// deep oceans, quantum accents and bioluminescent life, matching the
/// atmosphere described in the game concept.
class UCColors {
  /// A very dark blue background, like the primordial deep.
  static const bgDeep = Color(0xFF080A10);

  /// A slightly lighter dark blue used for radial gradients.
  static const bgDeep2 = Color(0xFF0B1220);

  /// Neon blue highlights for lightning and quantum effects.
  static const neonBlue = Color(0xFF60A5FA);

  /// Neon green used for emerging life.
  static const neonGreen = Color(0xFF34D399);

  /// Teal accent colour used for subtle interface elements.
  static const neonTeal = Color(0xFF10B981);

  /// Soft off-white for HUD text.
  static const softText = Color(0xFFEAEEFF);

  /// Pale blue hint colour for milestones and secondary text.
  static const hintText = Color(0xFF93C5FD);
}