import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flame/game.dart';

import 'game/connected_game.dart';

/// Entry point for the Universe Connected prototype.
///
/// We lock the orientation to landscape since the gameplay is designed for
/// horizontal screen space. The `GameWidget` wraps our custom [ConnectedGame]
/// class provided by the Flame engine.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Force landscape orientation; the game design assumes landscape.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(GameWidget(game: ConnectedGame()));
}