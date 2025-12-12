import 'package:flutter/material.dart';
import '../../../core/constants/color_constants.dart';

class TrialBanner extends StatelessWidget {
  final VoidCallback onActivate;

  const TrialBanner({super.key, required this.onActivate});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorConstants.accentLight,
            ColorConstants.accentMid,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.celebration, size: 40, color: ColorConstants.accentMid),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'جرب مجاناً لمدة 7 أيام',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'استمتع بكافة الميزات المتقدمة بدون دفع',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: onActivate,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.accentDark,
              foregroundColor: ColorConstants.surfaceColor,
            ),
            child: const Text('تفعيل التجربة'),
          ),
        ],
      ),
    );
  }
}