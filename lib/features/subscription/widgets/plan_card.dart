import 'package:flutter/material.dart';
import '../../../core/constants/color_constants.dart';

class PlanCard extends StatelessWidget {
  final String title;
  final String price;
  final String period;
  final List<String> features;
  final bool isRecommended;
  final VoidCallback onSubscribe;
  final String ctaLabel;
  final String? badgeText;

  const PlanCard({
    super.key,
    required this.title,
    required this.price,
    required this.period,
    required this.features,
    required this.isRecommended,
    required this.onSubscribe,
    required this.ctaLabel,
    this.badgeText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          border: isRecommended
              ? Border.all(color: Theme.of(context).primaryColor, width: 2)
              : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              if (isRecommended && badgeText != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    badgeText!,
                    style: const TextStyle(
                      color: ColorConstants.surfaceColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                price,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(period),
              const SizedBox(height: 16),
              ...features.map((feature) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    const Icon(Icons.check, color: ColorConstants.accentDark),
                    const SizedBox(width: 8),
                    Expanded(child: Text(feature)),
                  ],
                ),
              )),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: onSubscribe,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text(ctaLabel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}