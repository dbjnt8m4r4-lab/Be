import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class StreakRewardDialog extends StatefulWidget {
  final int streak;

  const StreakRewardDialog({
    super.key,
    required this.streak,
  });

  @override
  State<StreakRewardDialog> createState() => _StreakRewardDialogState();
}

class _StreakRewardDialogState extends State<StreakRewardDialog> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          // Confetti effect
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [Colors.green, Colors.blue, Colors.pink],
            ),
          ),
          // Dialog content
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '🔥',
                  style: TextStyle(fontSize: 64),
                ),
                const SizedBox(height: 16),
                Text(
                  'Streak Maintained!',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${widget.streak} day streak! Keep it up!',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Awesome!'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}





