import 'package:flutter/material.dart';
import '../../../core/constants/color_constants.dart';

class SuggestionList extends StatelessWidget {
  final List<String> suggestions;

  const SuggestionList({super.key, required this.suggestions});

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
                Icon(Icons.lightbulb, color: ColorConstants.accentMid),
                SizedBox(width: 8),
                Text(
                  'اقتراحات سريعة',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...suggestions.map((suggestion) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  const Icon(Icons.arrow_left, color: ColorConstants.accentDark),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      suggestion,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            )),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add quick task
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('إضافة كمهمة سريعة'),
            ),
          ],
        ),
      ),
    );
  }
}