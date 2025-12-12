import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../l10n/app_localizations.dart';
import '../providers/task_provider.dart';
import '../widgets/task_tile.dart';
import 'add_task_screen.dart';
import '../../../data/models/task_model.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  String _selectedFilter = 'all';
  final GlobalKey _filterButtonKey = GlobalKey();
  final GlobalKey _addTaskButtonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.tasks ?? 'Tasks'),
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          if (taskProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Set context only once, not on every build
          WidgetsBinding.instance.addPostFrameCallback((_) {
            taskProvider.setContext(context);
          });

          final allTasks = taskProvider.tasks;
          final tasks = taskProvider.getFilteredTasks(_selectedFilter);
          final dailyPoints = taskProvider.getTodayPoints();
          final completedTasks = allTasks.where((task) => task.isCompleted).length;
          final hasAnyTasks = allTasks.isNotEmpty;

          if (!hasAnyTasks) {
            // First time: clean page with centered "Add Tasks" button, no scale
            return _buildFirstTimeState(context, loc);
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: _buildTaskScaleCard(
                  context,
                  loc,
                  dailyPoints,
                  completedTasks,
                  allTasks.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                child: _buildFilterButton(loc),
              ),
              Expanded(
                child: tasks.isEmpty
                    ? _buildFilteredEmptyState(context, loc)
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          final task = tasks[index];
                          return TaskTile(
                            key: ValueKey(task.id),
                            task: task,
                            onToggle: (value) {
                              taskProvider.toggleTaskCompletion(task.id);
                            },
                            onEdit: () => _editTask(context, task),
                            onDelete: () => _showDeleteDialog(context, task),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Consumer<TaskProvider>(
        builder: (context, taskProvider, _) {
          if (taskProvider.tasks.isEmpty) {
            return const SizedBox.shrink();
          }
          return _buildBottomAddButton(
            context,
            loc.addTasksButton ?? loc.addTaskTitle ?? 'Add Tasks',
            () => _addTask(context),
          );
        },
      ),
    );
  }

  void _addTask(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTaskScreen()),
    );
  }

  void _editTask(BuildContext context, Task task) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTaskScreen(task: task),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, Task task) {
    final loc = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(loc.deleteTask ?? 'Delete Task'),
        content: Text('${loc.deleteTaskConfirm ?? 'Are you sure you want to delete'} "${task.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(loc.cancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<TaskProvider>(context, listen: false).deleteTask(task.id);
              Navigator.pop(context);
            },
            child: Text(loc.delete ?? 'Delete'),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskScaleCard(
    BuildContext context,
    AppLocalizations loc,
    double dailyPoints,
    int completed,
    int total,
  ) {
    final hasData = total > 0 && (completed > 0 || dailyPoints > 0);
    final grade = hasData ? _gradeFromPoints(dailyPoints) : '--';
    final gradeColor = hasData ? _gradeColor(grade) : Colors.grey;
    final completionRatio =
        !hasData ? 0.0 : (completed / total).clamp(0.0, 1.0);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.userPerformance ?? 'Performance',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loc.tasksProgressCount(completed, total),
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${dailyPoints.toStringAsFixed(0)} ${loc.pointsLabel}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: gradeColor.withOpacity(.15),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    grade,
                    style: TextStyle(
                      color: gradeColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: completionRatio,
                minHeight: 10,
                backgroundColor:
                    Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.4),
                valueColor: AlwaysStoppedAnimation<Color>(gradeColor),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                hasData ? _gradeDescription(loc, grade) : '',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: gradeColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(AppLocalizations loc) {
    final options = <MapEntry<String, String>>[
      MapEntry('all', loc.filterAll ?? 'All'),
      MapEntry('high', loc.filterHigh ?? 'High'),
      MapEntry('normal', loc.filterNormal ?? 'Normal'),
      MapEntry('low', loc.filterLow ?? 'Low'),
      MapEntry('pending', loc.pendingLabel ?? 'Pending'),
      MapEntry('completed', loc.completedLabel ?? 'Completed'),
    ];

    final currentLabel =
        options.firstWhere((e) => e.key == _selectedFilter, orElse: () => options.first).value;

    return SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          key: _filterButtonKey,
          icon: const Icon(Icons.filter_list),
          label: Text(currentLabel),
          onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            builder: (_) => SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: options.map((entry) {
                  final isSelected = entry.key == _selectedFilter;
                  return ListTile(
                    leading: isSelected
                        ? const Icon(Icons.check, color: Colors.blue)
                        : const SizedBox(width: 24),
                    title: Text(entry.value),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        _selectedFilter = entry.key;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFirstTimeState(BuildContext context, AppLocalizations loc) {
    final muted = Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.layers_outlined, size: 72, color: muted),
            const SizedBox(height: 16),
            Text(
              loc.noTasks ?? 'No tasks yet',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              loc.addTaskHint ?? 'Use the Add Tasks button to create your first task.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Center(
              child: SizedBox(
                width: 220,
                child: ElevatedButton.icon(
                  key: _addTaskButtonKey,
                  onPressed: () => _addTask(context),
                  icon: const Icon(Icons.add),
                  label: Text(loc.addTasksButton ?? loc.addTaskTitle ?? 'Add Tasks'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilteredEmptyState(BuildContext context, AppLocalizations loc) {
    final muted = Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.filter_list_off, size: 64, color: muted),
          const SizedBox(height: 12),
          Text(
            loc.noTasksFiltered ?? 'No tasks match this filter',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 4),
          Text(
            loc.filterLabel ?? 'Filter',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: muted),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomAddButton(BuildContext context, String label, VoidCallback onTap) {
    return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: SizedBox(
            height: 48,
            child: ElevatedButton.icon(
              key: _addTaskButtonKey,
              onPressed: onTap,
              icon: const Icon(Icons.add),
              label: Text(label),
            ),
          ),
        ),
      );
  }

  String _gradeFromPoints(double points) {
    if (points >= 95) return 'A+';
    if (points >= 90) return 'A';
    if (points >= 80) return 'B';
    if (points >= 70) return 'C';
    if (points >= 50) return 'D';
    return 'F';
  }

  Color _gradeColor(String grade) {
    switch (grade) {
      case 'A+':
      case 'A':
        return Colors.green;
      case 'B':
        return Colors.lightGreen;
      case 'C':
        return Colors.orangeAccent;
      case 'D':
        return Colors.deepOrange;
      default:
        return Colors.redAccent;
    }
  }

  String _gradeDescription(AppLocalizations loc, String grade) {
    switch (grade) {
      case 'A+':
      case 'A':
        return loc.performanceExcellent ?? 'Excellent';
      case 'B':
        return loc.performanceGood ?? 'Good';
      case 'C':
        return loc.performanceNeedsAttention ?? 'Needs focus';
      case 'D':
        return loc.performanceNeedsAttention ?? 'Needs focus';
      default:
        return loc.performanceNeedsAttention ?? 'Needs focus';
    }
  }
}