import 'package:flutter/material.dart';
import '../../../core/constants/color_constants.dart';
import '../../../l10n/app_localizations.dart';

class PrioritySelector extends StatefulWidget {
  final String selectedPriority;
  final Function(String) onPriorityChanged;

  const PrioritySelector({super.key, 
    required this.selectedPriority,
    required this.onPriorityChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _PrioritySelectorState createState() => _PrioritySelectorState();
}

class _PrioritySelectorState extends State<PrioritySelector> {
  late String _selectedPriority;

  @override
  void initState() {
    super.initState();
    _selectedPriority = widget.selectedPriority;
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          loc.priorityLabel,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildPriorityOption(loc.priorityHigh, 'high'),
            const SizedBox(width: 8),
            _buildPriorityOption(loc.priorityNormal, 'normal'),
            const SizedBox(width: 8),
            _buildPriorityOption(loc.priorityLow, 'low'),
          ],
        ),
      ],
    );
  }

  Widget _buildPriorityOption(String label, String priority) {
    final isSelected = _selectedPriority == priority;
    final color = ColorConstants.getPriorityColor(priority);

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedPriority = priority;
          });
          widget.onPriorityChanged(priority);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? color : color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? color : ColorConstants.accentLight,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}