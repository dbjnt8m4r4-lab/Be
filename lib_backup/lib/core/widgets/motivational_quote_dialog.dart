import 'package:flutter/material.dart';
import '../../core/utils/motivational_quotes.dart';

class MotivationalQuoteDialog extends StatelessWidget {
  final MotivationalQuote quote;

  const MotivationalQuoteDialog({
    super.key,
    required this.quote,
  });

  static Future<void> show(BuildContext context) async {
    final quote = MotivationalQuotes.getRandomQuote();
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => MotivationalQuoteDialog(quote: quote),
    );
  }

  static Future<void> showWithQuote(BuildContext context, String quoteText) async {
    // Find the quote object from the text
    final quote = MotivationalQuotes.quotes.firstWhere(
      (q) => q.quote == quoteText,
      orElse: () => MotivationalQuotes.getRandomQuote(),
    );
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => MotivationalQuoteDialog(quote: quote),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final backgroundColor = isDark ? Colors.grey[900] : Colors.grey[50];
    
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [Colors.grey[900]!, Colors.grey[800]!]
                : [Colors.white, Colors.grey[50]!],
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.3 * 255).round()),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Large emoji
            Text(
              quote.emoji,
              style: const TextStyle(fontSize: 64),
            ),
            const SizedBox(height: 24),
            // Quote text
            Text(
              quote.quote,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: textColor,
                height: 1.5,
                letterSpacing: 0.3,
              ),
              textAlign: TextAlign.center,
            ),
            if (quote.author != null) ...[
              const SizedBox(height: 16),
              // Author
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isDark 
                      ? Colors.white.withAlpha((0.1 * 255).round())
                      : Colors.black.withAlpha((0.05 * 255).round()),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '— ${quote.author}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: textColor.withOpacity(0.7),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 32),
            // Continue button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

