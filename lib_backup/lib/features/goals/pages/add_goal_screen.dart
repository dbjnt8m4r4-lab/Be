import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../../l10n/app_localizations.dart';
import '../providers/goal_provider.dart';
import '../../../data/models/goal_model.dart';

class AddGoalScreen extends StatefulWidget {
  final Goal? goal;

  const AddGoalScreen({super.key, this.goal});

  @override
  State<AddGoalScreen> createState() => _AddGoalScreenState();
}

class _AddGoalScreenState extends State<AddGoalScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _targetDate;
  bool _hasAIAssistant = false;
  final Uuid _uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    if (widget.goal != null) {
      _titleController.text = widget.goal!.title;
      _descriptionController.text = widget.goal!.description;
      _targetDate = widget.goal!.targetDate;
      _hasAIAssistant = widget.goal!.hasAIAssistant;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final isEditing = widget.goal != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? loc.editGoal ?? 'Edit Goal' : loc.addGoal ?? 'Add Goal'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: loc.goalTitle ?? 'Goal Title',
                hintText: loc.goalTitleHint ?? 'What do you want to become?',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.flag),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return loc.goalTitleRequired ?? 'Please enter a goal title';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: loc.goalDescription ?? 'Description',
                hintText: loc.goalDescriptionHint ?? 'Describe your goal in detail...',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.description),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _targetDate ?? DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 3650)),
                );
                if (date != null) {
                  setState(() {
                    _targetDate = date;
                  });
                }
              },
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: loc.targetDate ?? 'Target Date (Optional)',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.calendar_today),
                ),
                child: Text(
                  _targetDate != null
                      ? DateFormat('MMM d, y').format(_targetDate!)
                      : loc.selectDate ?? 'Select Date',
                  style: TextStyle(
                    color: _targetDate != null
                        ? Theme.of(context).textTheme.bodyLarge?.color
                        : Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: Text(loc.assignAIAssistant ?? 'Assign AI Assistant'),
              subtitle: Text(
                loc.aiAssistantHint ??
                    'Get help with problem-solving and motivation',
              ),
              value: _hasAIAssistant,
              onChanged: (value) {
                setState(() {
                  _hasAIAssistant = value;
                });
              },
              secondary: const Icon(Icons.smart_toy),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveGoal,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(isEditing ? loc.save ?? 'Save' : loc.addGoal ?? 'Add Goal'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveGoal() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final goalProvider = Provider.of<GoalProvider>(context, listen: false);
    final goal = Goal(
      id: widget.goal?.id ?? _uuid.v4(),
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      createdAt: widget.goal?.createdAt ?? DateTime.now(),
      targetDate: _targetDate,
      hasAIAssistant: _hasAIAssistant,
      aiAssistantId: _hasAIAssistant ? _uuid.v4() : null,
      progress: widget.goal?.progress ?? 0.0,
      progressEntries: widget.goal?.progressEntries ?? [],
      isCompleted: widget.goal?.isCompleted ?? false,
      completedAt: widget.goal?.completedAt,
    );

    if (widget.goal != null) {
      goalProvider.updateGoal(goal);
    } else {
      goalProvider.addGoal(goal);
    }

    Navigator.pop(context);
  }
}

