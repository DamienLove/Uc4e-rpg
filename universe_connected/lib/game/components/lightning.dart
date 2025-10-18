import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/gestures.dart';

import '../../util/colors.dart';

/// Signature for a callback invoked when a lightning bolt is finished.
typedef StrikeCallback = void Function(List<Vector2> polyline);

/// Handles drawing a lightning bolt using drag input. When the drag ends,
/// the collected points are passed to [onStrike].
class LightningController extends PositionComponent with Draggable {
  final StrikeCallback onStrike;
  final List<Vector2> _points = [];

  LightningController({required this.onStrike});

  @override
  bool onDragStart(DragStartInfo info) {
    _points.clear();
    _points.add(info.eventPosition.game);
    return true;
  }

  @override
  bool onDragUpdate(DragUpdateInfo info) {
    _points.add(info.eventPosition.game);
    return true;
  }

  @override
  bool onDragEnd(DragEndInfo info) {
    if (_points.length > 2) onStrike(List.of(_points));
    _points.clear();
    return true;
  }

  @override
  void render(Canvas c) {
    if (_points.length < 2) return;
    final path = Path()..moveTo(_points.first.x, _points.first.y);
    for (final v in _points.skip(1)) {
      path.lineTo(v.x, v.y);
    }
    final paint = Paint()
      ..color = UCColors.neonBlue
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    c.drawPath(path, paint);
  }
}