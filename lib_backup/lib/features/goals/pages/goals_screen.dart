import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../l10n/app_localizations.dart';
import '../providers/goal_provider.dart';
import '../../../data/models/goal_model.dart';
import 'add_goal_screen.dart';
import 'goal_detail_screen.dart';
import 'package:uuid/uuid.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  final GlobalKey _addGoalButtonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final goalProvider = Provider.of<GoalProvider>(context);
    final hasGoals =
        goalProvider.getActiveGoals().isNotEmpty || goalProvider.getCompletedGoals().isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.goals ?? 'Goals'),
      ),
      body: Consumer<GoalProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final activeGoals = provider.getActiveGoals();
          final completedGoals = provider.getCompletedGoals();

          if (activeGoals.isEmpty && completedGoals.isEmpty) {
            return _EmptyGoalsState(
              onAddGoal: () => _addGoal(context),
              loc: loc,
              addGoalButtonKey: _addGoalButtonKey,
            );
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (activeGoals.isNotEmpty) ...[
                Text(
                  loc.activeGoals ?? 'Active Goals',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                ...activeGoals.asMap().entries.map((entry) {
                  final index = entry.key;
                  final goal = entry.value;
                  return _GoalCard(
                    goal: goal,
                    onTap: () => _viewGoal(context, goal),
                    onDelete: () => _deleteGoal(context, goal),
                    onAddProgress: () => _addProgressToGoal(context, goal),
                    isFirst: index == 0,
                  );
                }),
                const SizedBox(height: 24),
              ],
              if (completedGoals.isNotEmpty) ...[
                Text(
                  loc.completedGoals ?? 'Completed Goals',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                ...completedGoals.map((goal) => _GoalCard(
                      goal: goal,
                      onTap: () => _viewGoal(context, goal),
                      onDelete: () => _deleteGoal(context, goal),
                      onAddProgress: () => _addProgressToGoal(context, goal),
                      isCompleted: true,
                    )),
              ],
            ],
          );
        },
      ),
      bottomNavigationBar: hasGoals
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton.icon(
                    key: _addGoalButtonKey,
                    onPressed: () => _addGoal(context),
                    icon: const Icon(Icons.add),
                    label: Text(loc.addGoal ?? 'Add Goal'),
                  ),
                ),
              ),
            )
          : null,
    );
  }

  void _addGoal(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddGoalScreen()),
    );
  }

  void _viewGoal(BuildContext context, Goal goal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GoalDetailScreen(goal: goal),
      ),
    );
  }

  void _deleteGoal(BuildContext context, Goal goal) {
    final loc = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(loc.deleteGoal ?? 'Delete Goal'),
        content: Text(loc.deleteGoalConfirm(goal.title)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(loc.cancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<GoalProvider>(context, listen: false)
                  .deleteGoal(goal.id);
              Navigator.pop(context);
            },
            child: Text(loc.delete ?? 'Delete'),
          ),
        ],
      ),
    );
  }

  void _addProgressToGoal(BuildContext context, Goal goal) {
    final loc = AppLocalizations.of(context)!;
    final goalProvider = Provider.of<GoalProvider>(context, listen: false);
    final noteController = TextEditingController();
    double progressChange = 0.0;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(loc.addProgress ?? 'Add Progress'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: noteController,
                  decoration: InputDecoration(
                    labelText: loc.progressNote ?? 'Note',
                    hintText: loc.progressNoteHint ?? 'What progress did you make?',
                    border: const OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                Text(
                  '${loc.progressChange ?? 'Progress Change'}: ${progressChange.toStringAsFixed(1)}%',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Slider(
                  value: progressChange,
                  min: -10.0,
                  max: 20.0,
                  divisions: 30,
                  label: '${progressChange.toStringAsFixed(1)}%',
                  onChanged: (value) {
                    setDialogState(() {
                      progressChange = value;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(loc.cancel ?? 'Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (noteController.text.trim().isNotEmpty) {
                  final entry = ProgressEntry(
                    id: const Uuid().v4(),
                    date: DateTime.now(),
                    note: noteController.text.trim(),
                    progressChange: progressChange,
                  );
                  goalProvider.addProgressEntry(goal.id, entry);
                  Navigator.pop(context);
                }
              },
              child: Text(loc.save ?? 'Save'),
            ),
          ],
        ),
      ),
    );
  }
}

class _GoalCard extends StatefulWidget {
  final Goal goal;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onAddProgress;
  final bool isCompleted;
  final bool isFirst;

  const _GoalCard({
    required this.goal,
    required this.onTap,
    required this.onDelete,
    required this.onAddProgress,
    this.isCompleted = false,
    this.isFirst = false,
  });

  @override
  State<_GoalCard> createState() => _GoalCardState();
}

class _GoalCardState extends State<_GoalCard> {
  @override
  Widget build(BuildContext context) {

    final loc = AppLocalizations.of(context)!;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.goal.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            decoration: widget.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: widget.onDelete,
                    color: Colors.red,
                  ),
                ],
              ),
              if (widget.goal.description.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  widget.goal.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.goal.progress.toStringAsFixed(0)}%',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: widget.goal.progress / 100,
                            minHeight: 8,
                            backgroundColor: Colors.grey[300],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              widget.isCompleted ? Colors.green : Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (widget.goal.hasAIAssistant)
                    const Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Icon(
                        Icons.smart_toy,
                        color: Colors.purple,
                        size: 20,
                      ),
                    ),
                ],
              ),
              if (widget.goal.targetDate != null) ...[
                const SizedBox(height: 8),
                Text(
                  'Target: ${DateFormat('MMM d, y').format(widget.goal.targetDate!)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
              const SizedBox(height: 12),
              // Add Progress Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: widget.onAddProgress,
                  icon: const Icon(Icons.add, size: 18),
                  label: Text(loc.addProgress ?? 'Add Progress'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyGoalsState extends StatelessWidget {
  final VoidCallback onAddGoal;
  final AppLocalizations loc;
  final GlobalKey addGoalButtonKey;

  const _EmptyGoalsState({
    required this.onAddGoal,
    required this.loc,
    required this.addGoalButtonKey,
  });

  @override
  Widget build(BuildContext context) {
    final mutedColor =
        Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.flag_outlined, size: 64, color: mutedColor),
            const SizedBox(height: 16),
            Text(
              loc.noGoals ?? 'No Goals Yet',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              loc.addGoalHint ??
                  'Set a goal to track your progress and achieve your dreams',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: mutedColor,
                  ),
            ),
            const SizedBox(height: 24),
            Center(
              child: SizedBox(
                width: 220,
                child: ElevatedButton.icon(
                  key: addGoalButtonKey,
                  onPressed: onAddGoal,
                  icon: const Icon(Icons.add),
                  label: Text(loc.addGoal ?? 'Add Goal'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
