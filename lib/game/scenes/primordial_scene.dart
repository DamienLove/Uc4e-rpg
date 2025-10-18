import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';

import '../components/molecule.dart';
import '../components/lightning.dart';
import '../components/protocell.dart';
import '../systems/reaction_system.dart';
import '../ui/hud.dart';
import '../../util/colors.dart';

/// A playable slice representing the primordial ocean and the birth of the
/// first protocell.
class PrimordialScene extends PositionComponent with HasGameRef {
  /// Dimensions of the world; passed in from the main game.
  final Vector2 worldSize;

  PrimordialScene(this.worldSize);

  late final ReactionSystem _reactions;
  late final Hud _hud;
  final _rng = Random();

  @override
  Future<void> onLoad() async {
    size = worldSize;

    // Add a gradient background.
    final bg = RectangleComponent(
      size: size,
      paint: Paint()
        ..shader = Gradient.radial(
          size / 2,
          UCColors.bgDeep2,
          UCColors.bgDeep,
        ),
    );
    add(bg);

    // Initialize and optionally play ambient audio (commented out until assets exist).
    // await FlameAudio.bgm.initialize();
    // await FlameAudio.bgm.play('ambient_primordial.ogg', volume: 0.35);

    // Reaction system controls amino synthesis and protocell spawning.
    _reactions = ReactionSystem(
      onAminoSynthesized: _onAmino,
      onProtocellBorn: _onProtocell,
    );
    add(_reactions);

    // Spawn a collection of random molecules.
    for (int i = 0; i < 40; i++) {
      final pos = Vector2(
        _rng.nextDouble() * size.x,
        _rng.nextDouble() * size.y,
      );
      add(Molecule.randomAt(pos));
    }

    // Lightning controller for drawing strikes on drag.
    add(LightningController(onStrike: _reactions.onStrike));

    // Heads-up display for amino count and milestones.
    _hud = Hud();
    add(_hud);
  }

  void _onAmino(int total) => _hud.updateAmino(total);

  Future<void> _onProtocell(Vector2 at) async {
    final cell = Protocell(at);
    await add(cell);
    await cell.bloom();
    _hud.showMilestone('Protocell formed');
    // Future: transition to next scene.
  }
}