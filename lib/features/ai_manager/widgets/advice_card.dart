import 'package:flutter/material.dart';
import '../../../core/constants/color_constants.dart';

class AdviceCard extends StatelessWidget {
  final String advice;

  const AdviceCard({super.key, required this.advice});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.psychology, color: ColorConstants.secondaryColor),
                SizedBox(width: 8),
                Text(
                  'نصيحة المدير',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              advice.isNotEmpty ? advice : 'جاري تحليل أدائك...',
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 16),
            if (advice.isNotEmpty)
              const Text(
                'نصيحة مقدمة من مدير الذكاء الاصطناعي',
                style: TextStyle(
                  fontSize: 12,
                  color: ColorConstants.accentLight,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}