import 'package:flutter/material.dart';

class AnimatedTextReveal extends StatefulWidget {
  final String title;
  final String description;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;
  final Duration delayBetweenLines;
  final Duration duration;

  const AnimatedTextReveal({
    required this.title,
    required this.description,
    this.titleStyle,
    this.descriptionStyle,
    this.delayBetweenLines = const Duration(milliseconds: 800),
    this.duration = const Duration(milliseconds: 800),
    super.key,
  });

  @override
  State<AnimatedTextReveal> createState() => _AnimatedTextRevealState();
}

class _AnimatedTextRevealState extends State<AnimatedTextReveal>
    with TickerProviderStateMixin {
  late AnimationController _titleController;
  late AnimationController _descriptionController;
  late Animation<double> _titleAnimation;
  late Animation<double> _descriptionAnimation;

  @override
  void initState() {
    super.initState();
    _titleController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _descriptionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _titleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _titleController, curve: Curves.easeOut),
    );

    _descriptionAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _descriptionController, curve: Curves.easeOut),
    );

    // Start animations in sequence
    _titleController.forward().then((_) {
      _descriptionController.forward();
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Animated Title
        FadeTransition(
          opacity: _titleAnimation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.3),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: _titleController, curve: Curves.easeOut),
            ),
            child: Text(
              widget.title,
              style: widget.titleStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Animated Description
        FadeTransition(
          opacity: _descriptionAnimation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.3),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: _descriptionController, curve: Curves.easeOut),
            ),
            child: Text(
              widget.description,
              style: widget.descriptionStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
