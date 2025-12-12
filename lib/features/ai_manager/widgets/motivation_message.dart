import 'package:flutter/material.dart';
import '../../../core/constants/color_constants.dart';

class MotivationMessage extends StatelessWidget {
  const MotivationMessage({super.key});

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
      child: const Row(
        children: [
          Icon(Icons.auto_awesome, size: 40, color: ColorConstants.accentMid),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'أنت على الطريق الصحيح!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'استمر في العمل الجاد وسترى النتائج قريباً',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}