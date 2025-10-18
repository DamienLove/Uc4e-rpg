import 'package:flame/components.dart';

import '../../util/colors.dart';

/// Simple heads-up display showing amino acid count and milestone messages.
class Hud extends PositionComponent with HasGameRef {
  late TextComponent _aminoText;
  late TextComponent _milestone;

  @override
  Future<void> onLoad() async {
    // Position the HUD in the top-left corner with a small margin.
    position = Vector2(16, 16);
    _aminoText = TextComponent(
      text: 'Amino: 0',
      textRenderer: TextPaint(
        style: const TextStyle(color: UCColors.softText, fontSize: 16),
      ),
    );
    add(_aminoText);

    _milestone = TextComponent(
      text: '',
      position: Vector2(0, 28),
      textRenderer: TextPaint(
        style: const TextStyle(color: UCColors.hintText, fontSize: 14),
      ),
    );
    add(_milestone);
  }

  /// Update the displayed amino acid count.
  void updateAmino(int value) {
    _aminoText.text = 'Amino: $value';
  }

  /// Show a milestone message briefly.
  void showMilestone(String msg) {
    _milestone.text = msg;
    Future.delayed(const Duration(seconds: 2), () {
      _milestone.text = '';
    });
  }
}