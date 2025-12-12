import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../../l10n/app_localizations.dart';
import '../providers/goal_provider.dart';
import '../../../data/models/goal_model.dart';
import 'add_goal_screen.dart';

class GoalDetailScreen extends StatefulWidget {
  final Goal goal;

  const GoalDetailScreen({super.key, required this.goal});

  @override
  State<GoalDetailScreen> createState() => _GoalDetailScreenState();
}

class _GoalDetailScreenState extends State<GoalDetailScreen> {
  late Goal _currentGoal;
  final Uuid _uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    _currentGoal = widget.goal;
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final goalProvider = Provider.of<GoalProvider>(context);

    // Listen to goal updates
    goalProvider.addListener(_onGoalUpdated);

    return Scaffold(
      appBar: AppBar(
        title: Text(_currentGoal.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _editGoal(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${_currentGoal.progress.toStringAsFixed(0)}%',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        if (_currentGoal.hasAIAssistant)
                          Chip(
                            avatar: const Icon(Icons.smart_toy, size: 18),
                            label: Text(loc.aiAssistant ?? 'AI Assistant'),
                            backgroundColor: Colors.purple.withOpacity(0.2),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: _currentGoal.progress / 100,
                        minHeight: 12,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _currentGoal.isCompleted ? Colors.green : Colors.blue,
                        ),
                      ),
                    ),
                    if (_currentGoal.targetDate != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        'Target Date: ${DateFormat('MMM d, y').format(_currentGoal.targetDate!)}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Description
            if (_currentGoal.description.isNotEmpty) ...[
              Text(
                loc.description ?? 'Description',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                _currentGoal.description,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
            ],
            // Progress Entries
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  loc.progressHistory ?? 'Progress History',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                TextButton.icon(
                  onPressed: () => _addProgressEntry(context),
                  icon: const Icon(Icons.add),
                  label: Text(loc.addProgress ?? 'Add Progress'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (_currentGoal.progressEntries.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    loc.noProgressEntries ?? 'No progress entries yet',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ),
              )
            else
              ..._currentGoal.progressEntries.reversed.map((entry) => Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Icon(
                          entry.progressChange >= 0
                              ? Icons.trending_up
                              : Icons.trending_down,
                        ),
                      ),
                      title: Text(
                        DateFormat('MMM d, y - h:mm a').format(entry.date),
                      ),
                      subtitle: Text(entry.note),
                      trailing: Text(
                        '${entry.progressChange >= 0 ? '+' : ''}${entry.progressChange.toStringAsFixed(1)}%',
                        style: TextStyle(
                          color: entry.progressChange >= 0
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )),
            const SizedBox(height: 24),
            // AI Assistant Section
            if (_currentGoal.hasAIAssistant) ...[
              Card(
                color: Colors.purple.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.smart_toy, color: Colors.purple),
                          const SizedBox(width: 8),
                          Text(
                            loc.aiAssistant ?? 'AI Assistant',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Consumer<GoalProvider>(
                        builder: (context, provider, child) {
                          if (provider.isLoadingAI) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          if (provider.aiAdvice != null &&
                              provider.aiAdvice!.isNotEmpty) {
                            return Text(
                              provider.aiAdvice!,
                              style: Theme.of(context).textTheme.bodyMedium,
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        onPressed: () {
                          goalProvider.getGoalAdvice(_currentGoal.id);
                        },
                        icon: const Icon(Icons.psychology),
                        label: Text(loc.getAdvice ?? 'Get Advice'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _onGoalUpdated() {
    final goalProvider = Provider.of<GoalProvider>(context, listen: false);
    final updatedGoal = goalProvider.goals.firstWhere(
      (g) => g.id == _currentGoal.id,
      orElse: () => _currentGoal,
    );
    if (updatedGoal.id == _currentGoal.id) {
      setState(() {
        _currentGoal = updatedGoal;
      });
    }
  }

  void _editGoal(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddGoalScreen(goal: _currentGoal),
      ),
    ).then((_) {
      // Refresh goal after editing
      final goalProvider = Provider.of<GoalProvider>(context, listen: false);
      final updatedGoal = goalProvider.goals.firstWhere(
        (g) => g.id == _currentGoal.id,
        orElse: () => _currentGoal,
      );
      setState(() {
        _currentGoal = updatedGoal;
      });
    });
  }

  void _addProgressEntry(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
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
                    id: _uuid.v4(),
                    date: DateTime.now(),
                    note: noteController.text.trim(),
                    progressChange: progressChange,
                  );
                  Provider.of<GoalProvider>(context, listen: false)
                      .addProgressEntry(_currentGoal.id, entry);
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

  @override
  void dispose() {
    final goalProvider = Provider.of<GoalProvider>(context, listen: false);
    goalProvider.removeListener(_onGoalUpdated);
    super.dispose();
  }
}

