import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/constants/color_constants.dart';
import '../../../data/models/task_model.dart';
import '../../../features/tasks/providers/task_provider.dart';
import '../../../services/notification_service.dart';

class TaskDetailScreen extends StatefulWidget {
  final Task task;

  const TaskDetailScreen({super.key, required this.task});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late Task _task;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    _task = widget.task;
    _titleController.text = _task.title;
    _descriptionController.text = _task.description ?? '';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _updateTask() {
    final updatedTask = _task.copyWith(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
    );

    Provider.of<TaskProvider>(context, listen: false).updateTask(updatedTask);
    setState(() => _task = updatedTask);
  }

  void _toggleTaskCompletion() {
    final updatedTask = _task.copyWith(
      isCompleted: !_task.isCompleted,
      completedAt: !_task.isCompleted ? DateTime.now() : null,
    );

    Provider.of<TaskProvider>(context, listen: false).updateTask(updatedTask);
    setState(() => _task = updatedTask);
  }

  void _deleteTask() {
    Provider.of<TaskProvider>(context, listen: false).deleteTask(_task.id);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).appBarTheme.iconTheme?.color),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          loc.taskDetails,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: ColorConstants.errorColor),
            onPressed: _deleteTask,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Task Title
            TextField(
              controller: _titleController,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: loc.taskTitle,
                hintStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5),
                ),
              ),
              maxLines: null,
              onChanged: (_) => _updateTask(),
            ),

            const SizedBox(height: 16),

            // Task Description
            TextField(
              controller: _descriptionController,
              style: Theme.of(context).textTheme.bodyLarge,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: loc.taskDescription,
                hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5),
                ),
              ),
              maxLines: null,
              onChanged: (_) => _updateTask(),
            ),

            const SizedBox(height: 24),

            // Priority Indicator
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: ColorConstants.getPriorityColor(_task.priority),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _getPriorityText(_task.priority, loc),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Completion Toggle
            Row(
              children: [
                Checkbox(
                  value: _task.isCompleted,
                  onChanged: (_) => _toggleTaskCompletion(),
                  activeColor: ColorConstants.successColor,
                ),
                const SizedBox(width: 12),
                Text(
                  _task.isCompleted ? loc.taskCompleted : loc.taskPending,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    decoration: _task.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
              ],
            ),

            if (_task.isCompleted && _task.completedAt != null) ...[
              const SizedBox(height: 8),
              Text(
                '${loc.completedAt}: ${_formatDateTime(_task.completedAt!)}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                ),
              ),
            ],

            const SizedBox(height: 24),

            // Task Statistics
            ...[
            Text(
              '${loc.createdAt}: ${_formatDateTime(_task.createdAt)}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 8),
          ],
          ],
        ),
      ),
    );
  }

  String _getPriorityText(String priority, AppLocalizations loc) {
    switch (priority) {
      case 'high':
        return loc.priorityHigh;
      case 'normal':
        return loc.priorityNormal;
      case 'low':
        return loc.priorityLow;
      default:
        return priority;
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
