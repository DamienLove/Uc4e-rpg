import 'dart:math';

import 'package:flame/components.dart';

import '../components/molecule.dart';

/// System handling interactions between lightning strikes and molecules.
///
/// When a strike intersects enough molecules it synthesises amino acids. After
/// a threshold of amino acids the first protocell is born at the end of the
/// lightning path. This class encapsulates the rules for counting hits and
/// triggering callbacks.
class ReactionSystem extends Component with HasGameRef {
  final void Function(int totalAmino) onAminoSynthesized;
  final Future<void> Function(Vector2 at) onProtocellBorn;
  int _aminoCount = 0;
  final _rng = Random();

  ReactionSystem({
    required this.onAminoSynthesized,
    required this.onProtocellBorn,
  });

  /// Called when the player releases a lightning bolt. Determines how many
  /// molecules were struck and synthesises amino acids accordingly.
  void onStrike(List<Vector2> boltPath) {
    final molecules = game.children.whereType<Molecule>().toList();
    int hits = 0;
    for (final m in molecules) {
      for (int i = 0; i < boltPath.length - 1; i++) {
        final a = boltPath[i], b = boltPath[i + 1];
        final d = _distancePointToSegment(m.position, a, b);
        if (d < m.radius + 10) {
          hits++;
          break;
        }
      }
    }
    final made = (hits / 5).floor(); // ~5 hits -> 1 amino acid
    if (made > 0) {
      _aminoCount += made;
      onAminoSynthesized(_aminoCount);
      // Push nearby particles away a bit for visual feedback.
      for (int k = 0; k < made; k++) {
        final p = boltPath[_rng.nextInt(boltPath.length)];
        _scatter(molecules, p, 120);
      }
      if (_aminoCount >= 10) {
        _aminoCount = 0;
        onProtocellBorn(boltPath.last);
      }
    }
  }

  void _scatter(List<Molecule> mols, Vector2 center, double force) {
    for (final m in mols) {
      final v = m.position - center;
      final len = v.length + 0.001;
      m.velocity += (v / len)..scale(force / len);
    }
  }

  double _distancePointToSegment(Vector2 p, Vector2 a, Vector2 b) {
    final ab = b - a;
    final t = ((p - a).dot(ab) / (ab.length2)).clamp(0.0, 1.0);
    final proj = a + ab * t;
    return (p - proj).length;
  }
}