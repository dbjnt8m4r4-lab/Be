import 'package:flutter/material.dart';
import '../../../core/constants/color_constants.dart';

class FeatureList extends StatelessWidget {
  const FeatureList({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'الميزات المتضمنة:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildFeatureItem('تحليلات متقدمة', Icons.analytics),
            _buildFeatureItem('لوحة المتصدرين', Icons.leaderboard),
            _buildFeatureItem('مدير الذكاء الاصطناعي', Icons.smart_toy),
            _buildFeatureItem('إشعارات مخصصة', Icons.notifications),
            _buildFeatureItem('مهام غير محدودة', Icons.task),
            _buildFeatureItem('عادات متقدمة', Icons.psychology),
            _buildFeatureItem('دعم فني متميز', Icons.support_agent),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String feature, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: ColorConstants.secondaryColor),
          const SizedBox(width: 8),
          Text(feature),
        ],
      ),
    );
  }
}