import 'package:flutter/material.dart';
import '../../../core/constants/color_constants.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              size: 80,
              color: ColorConstants.accentDark,
            ),
            const SizedBox(height: 24),
            const Text(
              'تم الدفع بنجاح!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'شكراً لاشتراكك في To Be',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'يمكنك الآن الاستفادة من جميع الميزات المتقدمة',
              style: TextStyle(fontSize: 14, color: ColorConstants.accentLight),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/tasks');
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
              ),
              child: const Text('البدء في الاستخدام'),
            ),
          ],
        ),
      ),
    );
  }
}