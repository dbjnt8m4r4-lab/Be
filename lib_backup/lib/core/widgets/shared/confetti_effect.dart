import 'package:flutter/material.dart';
import '../../constants/color_constants.dart';
import 'package:confetti/confetti.dart';

class ConfettiEffect extends StatefulWidget {
  final Widget child;
  final bool showConfetti;

  const ConfettiEffect({super.key, 
    required this.child,
    required this.showConfetti,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ConfettiEffectState createState() => _ConfettiEffectState();
}

class _ConfettiEffectState extends State<ConfettiEffect> {
  final ConfettiController _confettiController = ConfettiController();

  @override
  void initState() {
    super.initState();
    if (widget.showConfetti) {
      _confettiController.play();
    }
  }

  @override
  void didUpdateWidget(ConfettiEffect oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showConfetti && !oldWidget.showConfetti) {
      _confettiController.play();
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (widget.showConfetti)
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                ColorConstants.accentDark,
                ColorConstants.secondaryColor,
                ColorConstants.accentLight,
                ColorConstants.accentMid,
                ColorConstants.accentDark,
              ],
            ),
          ),
      ],
    );
  }
}