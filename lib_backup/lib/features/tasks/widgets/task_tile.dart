import 'package:flutter/material.dart';
import '../../../data/models/task_model.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/constants/app_constants.dart';
import '../../../l10n/app_localizations.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final Function(bool) onToggle;
  final Function onEdit;
  final Function onDelete;

  const TaskTile({super.key, 
    required this.task,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final isMultiplePerDay = task.repetition?.type == RepetitionType.multiplePerDay;
    
    return Card(
      elevation: task.isCompleted ? 1 : 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: task.isCompleted 
              ? null 
              : LinearGradient(
                  colors: [
                    ColorConstants.getPriorityColor(task.priority).withOpacity(0.1),
                    Colors.transparent,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
        ),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          leading: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: task.isCompleted 
                    ? Colors.grey 
                    : ColorConstants.getPriorityColor(task.priority),
                width: 2,
              ),
            ),
            child: Checkbox(
          value: task.isCompleted,
          onChanged: (value) => onToggle(value!),
              fillColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return ColorConstants.getPriorityColor(task.priority);
                }
                return Colors.transparent;
              }),
            ),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: task.isCompleted ? Colors.grey : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (task.description.isNotEmpty)
              Text(
                task.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: ColorConstants.getPriorityColor(task.priority),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _priorityLabel(loc, task.priority),
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
                if (isMultiplePerDay) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${task.completedCount}/${task.repetition!.targetCount}',
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit, color: Theme.of(context).colorScheme.onSurface),
                  const SizedBox(width: 8),
                  Text(loc.edit),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
                  const SizedBox(width: 8),
                  Text(
                    loc.delete,
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ],
              ),
            ),
          ],
          onSelected: (value) {
            if (value == 'edit') onEdit();
            if (value == 'delete') onDelete();
          },
        ),
        ),
      ),
    );
  }

  String _priorityLabel(AppLocalizations loc, String priority) {
    switch (priority) {
      case Priority.high:
        return loc.priorityHigh;
      case Priority.normal:
        return loc.priorityNormal;
      case Priority.low:
      default:
        return loc.priorityLow;
    }
  }
}