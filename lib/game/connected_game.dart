import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

import '../util/colors.dart';
import 'scenes/primordial_scene.dart';

/// The root game class. This sets up the initial scene and defines global
/// behaviours such as tap and drag handling and collision detection.
class ConnectedGame extends FlameGame
    with HasTappables, HasDraggables, HasCollisionDetection {
  @override
  Color backgroundColor() => UCColors.bgDeep;

  @override
  Future<void> onLoad() async {
    // Add the first scene; future versions could transition to other scenes.
    await add(PrimordialScene(size));
  }
}