import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/habit_model.dart';
import '../../../l10n/app_localizations.dart';
import '../providers/habit_provider.dart';

class HabitCard extends StatefulWidget {
  final Habit habit;
  final VoidCallback onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const HabitCard({super.key, 
    required this.habit,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  State<HabitCard> createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> {
  bool _isExpanded = false;

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              widget.habit.category == 'lock_in' 
                  ? Colors.green.withOpacity(0.1)
                  : Colors.orange.withOpacity(0.1),
              Colors.transparent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: Name, Type, and Menu button
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.habit.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: widget.habit.category == 'lock_in' 
                        ? Colors.black 
                        : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: widget.habit.category == 'kick_habit' 
                        ? Border.all(color: Colors.black, width: 1)
                        : null,
                  ),
                  child: Text(
                    widget.habit.category == 'lock_in' ? loc.lockIn : loc.kickHabit,
                    style: TextStyle(
                      fontSize: 10, 
                      color: widget.habit.category == 'lock_in' 
                          ? Colors.white 
                          : Colors.black,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                PopupMenuButton(
                  icon: const Icon(Icons.more_vert, size: 18),
                  padding: EdgeInsets.zero,
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 16, color: Theme.of(context).colorScheme.onSurface),
                          const SizedBox(width: 4),
                          Text(loc.edit, style: const TextStyle(fontSize: 13)),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, size: 16, color: Theme.of(context).colorScheme.error),
                          const SizedBox(width: 4),
                          Text(
                            loc.delete,
                            style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.error),
                          ),
                        ],
                      ),
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 'edit') widget.onEdit();
                    if (value == 'delete') widget.onDelete();
                  },
                ),
              ],
            ),

            // Description (if exists) - very compact
            if (widget.habit.description.isNotEmpty) 
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  widget.habit.description,
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

            // Calendar and "Show all days" in one row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildHabitCalendar(context),
                ),
                // "Show all days" button - only if needed
                if (widget.habit.targetDays > 14)
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: TextButton(
                      onPressed: _toggleExpand,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        _isExpanded ? 'Less' : 'All',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
          ),
        ),
      ),
    );
  }

  Widget _buildHabitCalendar(BuildContext context) {
    final int totalDays = widget.habit.targetDays;
    const int collapsedDays = 14;
    final int daysToShow = _isExpanded ? totalDays : (totalDays < collapsedDays ? totalDays : collapsedDays);
    
    final List<int> days = List.generate(daysToShow, (index) => index + 1);
    
    return Wrap(
      spacing: 2,
      runSpacing: 2,
      children: days.map((dayNumber) {
        final date = widget.habit.startDate.add(Duration(days: dayNumber - 1));
        final today = DateTime.now();
        
        final isCompleted = widget.habit.completedDates.any((completedDate) =>
            completedDate.year == date.year &&
            completedDate.month == date.month &&
            completedDate.day == date.day);
            
        final isToday = date.year == today.year &&
            date.month == today.month &&
            date.day == today.day;
        
        final isFuture = date.isAfter(today);
        
        return GestureDetector(
          onTap: isFuture ? null : () {
            _toggleHabitDate(context, date);
          },
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: isCompleted
                  ? Colors.blue
                  : (isToday
                      ? Colors.blue.withAlpha((0.3 * 255).round())
                      : Colors.transparent),
              border: Border.all(
                color: isCompleted 
                    ? Colors.blue 
                    : (isToday
                        ? Colors.blue
                        : Colors.grey.withOpacity(0.3)),
                width: isToday ? 1.5 : 1,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: isCompleted
                  ? const Icon(
                      Icons.check,
                      size: 14,
                      color: Colors.white,
                    )
                  : Text(
                      '$dayNumber',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                        color: isToday
                            ? Colors.blue
                            : (isFuture ? Colors.grey.withOpacity(0.3) : Colors.grey),
                      ),
                    ),
            ),
          ),
        );
      }).toList(),
    );
  }

  void _toggleHabitDate(BuildContext context, DateTime date) {
    context.read<HabitProvider>().toggleHabitDate(widget.habit.id, date);
  }
}