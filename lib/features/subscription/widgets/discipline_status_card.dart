import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

class DisciplineStatusCard extends StatelessWidget {
  final bool isExtraProgramSelected;
  final bool hasActiveSubscription;
  final VoidCallback onPrimaryAction;
  final VoidCallback onSecondaryAction;

  const DisciplineStatusCard({
    super.key,
    required this.isExtraProgramSelected,
    required this.hasActiveSubscription,
    required this.onPrimaryAction,
    required this.onSecondaryAction,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final title = isExtraProgramSelected
        ? loc.extraProgramName
        : loc.standardProgramName;
    final subtitle = isExtraProgramSelected
        ? (hasActiveSubscription
            ? loc.extraProgramActiveMessage
            : loc.extraProgramPendingMessage)
        : loc.standardProgramDescription;
    final primaryLabel = isExtraProgramSelected
        ? (hasActiveSubscription
            ? loc.manageProgramButton
            : loc.completePaymentButton)
        : loc.joinProgramButton;

    final colorScheme = theme.colorScheme;

    return Card(
      color: colorScheme.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: isExtraProgramSelected
              ? colorScheme.primary
              : colorScheme.outlineVariant,
          width: 1.4,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: colorScheme.primary, width: 2),
              ),
              child: Icon(
                isExtraProgramSelected ? Icons.verified : Icons.flag_outlined,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onPrimaryAction,
                          child: Text(primaryLabel),
                        ),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton(
                        onPressed: onSecondaryAction,
                        child: Text(loc.learnMoreLabel),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

