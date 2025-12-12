import 'package:flutter/material.dart';

/// Main character widget for Kryonos.
/// Supports simple emotion states that affect the aura around him.
class KryonosEmotion {
  static const neutral = KryonosEmotion._('neutral');
  static const focused = KryonosEmotion._('focused');
  static const proud = KryonosEmotion._('proud');
  static const encouraging = KryonosEmotion._('encouraging');
  static const happy = KryonosEmotion._('happy');
  static const sad = KryonosEmotion._('sad');
  static const tired = KryonosEmotion._('tired');
  static const angry = KryonosEmotion._('angry');
  static const celebrating = KryonosEmotion._('celebrating');

  final String value;
  const KryonosEmotion._(this.value);
}

class KryonosCharacter extends StatelessWidget {
  final double size;
  final KryonosEmotion emotion;

  const KryonosCharacter({
    super.key,
    this.size = 120,
    this.emotion = KryonosEmotion.neutral,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color auraColor;
    switch (emotion.value) {
      case 'focused':
        auraColor = Colors.blueAccent.withOpacity(0.5);
        break;
      case 'proud':
        auraColor = Colors.amber.withOpacity(0.6);
        break;
      case 'encouraging':
        auraColor = Colors.greenAccent.withOpacity(0.5);
        break;
      case 'happy':
        auraColor = Colors.lightGreenAccent.withOpacity(0.6);
        break;
      case 'sad':
        auraColor = Colors.indigo.withOpacity(0.5);
        break;
      case 'tired':
        auraColor = Colors.grey.withOpacity(0.5);
        break;
      case 'angry':
        auraColor = Colors.redAccent.withOpacity(0.6);
        break;
      case 'celebrating':
        auraColor = Colors.pinkAccent.withOpacity(0.7);
        break;
      case 'neutral':
      default:
        auraColor = (isDark ? Colors.white24 : Colors.black12);
        break;
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [auraColor, Colors.transparent],
          center: Alignment.center,
          radius: 0.9,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.fitness_center,
          size: size * 0.6,
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
