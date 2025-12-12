import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../../../data/models/task_model.dart';
import '../../../l10n/app_localizations.dart';

class AddTaskScreen extends StatefulWidget {
  final Task? task;

  const AddTaskScreen({super.key, this.task});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  String _priority = 'normal';
  DateTime? _dueDate;
  TimeOfDay? _reminderTime;
  int _estimatedDuration = 60;
  Repetition _repetition = Repetition(type: RepetitionType.none);

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      _priority = widget.task!.priority;
      _dueDate = widget.task!.dueDate;
      _reminderTime = widget.task!.reminderTime;
      _estimatedDuration = widget.task!.estimatedDuration;
      if (widget.task!.repetition != null) {
        _repetition = widget.task!.repetition!;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? loc.addTaskTitle : loc.editTaskTitle),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: _saveTask,
              child: Text(
                widget.task == null ? loc.addTaskTitle : loc.save,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.only(bottom: 120),
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: loc.taskTitleLabel,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return loc.enterTaskTitle;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: loc.taskDescriptionLabel,
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              // Priority selection
              Text(loc.priorityLabel, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    _buildPriorityButton(
                      label: loc.priorityLow,
                      value: 'low',
                      color: Colors.green,
                      isSelected: _priority == 'low',
                    ),
                    _buildPriorityButton(
                      label: loc.priorityNormal,
                      value: 'normal',
                      color: Colors.orange,
                      isSelected: _priority == 'normal',
                    ),
                    _buildPriorityButton(
                      label: loc.priorityHigh,
                      value: 'high',
                      color: Colors.red,
                      isSelected: _priority == 'high',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              Card(
                child: ExpansionTile(
                  leading: const Icon(Icons.repeat),
                  title: Text(loc.repetitionLabel),
                  subtitle: Text(_getRepetitionText(loc)),
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Type selection
            Text(
              loc.repeatTypeLabel,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(8),
              ),
                  child: DropdownButton<RepetitionType>(
                    value: _repetition.type,
                    isExpanded: true,
                    underline: const SizedBox(),
                    items: RepetitionType.values.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(_getRepetitionTypeText(loc, type)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _repetition = Repetition(type: value!);
                      });
                    },
                  ),
            ),
            
            const SizedBox(height: 16),
            
            // Conditional fields based on type
            if (_repetition.type == RepetitionType.customDays) ...[
              Text(
                loc.repeatEveryDays((_repetition.interval ?? 1).toString()),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  hintText: loc.enterNumberOfDays,
                  border: const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                initialValue: _repetition.interval?.toString() ?? '1',
                onChanged: (value) {
                  setState(() {
                    _repetition = Repetition(
                      type: _repetition.type,
                      interval: int.tryParse(value) ?? 1,
                    );
                  });
                },
              ),
            ],
            
            if (_repetition.type == RepetitionType.multiplePerDay) ...[
              Text(
                loc.timesPerDayLabel,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  hintText: loc.enterNumberOfTimes,
                  border: const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                initialValue: _repetition.targetCount.toString(),
                onChanged: (value) {
                  setState(() {
                    _repetition = Repetition(
                      type: _repetition.type,
                      targetCount: int.tryParse(value) ?? 1,
                    );
                  });
                },
              ),
            ],
            
            const SizedBox(height: 16),
          ],
        ),
      ),
    ],
  ),
),
              
              const SizedBox(height: 16),

              // Due Date
              Card(
                child: ListTile(
                  leading: const Icon(Icons.calendar_today),
                  title: Text(loc.dueDateLabel),
                  subtitle: Text(_dueDate == null 
                      ? loc.noDateSelected
                      : '${_dueDate!.day}/${_dueDate!.month}/${_dueDate!.year}'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: _selectDueDate,
                ),
              ),
              
              // Reminder Time
              Card(
                child: ListTile(
                  leading: const Icon(Icons.access_time),
                  title: Text(loc.reminderTimeLabel),
                  subtitle: Text(_reminderTime == null
                      ? loc.noReminderSet
                      : '${_reminderTime!.hour}:${_reminderTime!.minute.toString().padLeft(2, '0')}'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: _selectReminderTime,
                ),
              ),
              
              // Estimated Duration
              Card(
                child: ListTile(
                  leading: const Icon(Icons.timer),
                  title: Text(loc.estimatedDurationLabel),
                  subtitle: Text(loc.durationInMinutes(_estimatedDuration.toString())),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (_estimatedDuration > 15) {
                              _estimatedDuration -= 15;
                            }
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            _estimatedDuration += 15;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getRepetitionText(AppLocalizations loc) {
    switch (_repetition.type) {
      case RepetitionType.none: return loc.noRepetition;
      case RepetitionType.daily: return loc.repeatDaily;
      case RepetitionType.weekly: return loc.repeatWeekly;
      case RepetitionType.monthly: return loc.repeatMonthly;
      case RepetitionType.customDays:
        return loc.repeatEveryDays((_repetition.interval ?? 1).toString());
      case RepetitionType.multiplePerDay:
        final count = _repetition.targetCount;
        return '$count ${loc.timesPerDayLabel}';
    }
  }

  String _getRepetitionTypeText(AppLocalizations loc, RepetitionType type) {
    switch (type) {
      case RepetitionType.none: return loc.repeatNone;
      case RepetitionType.daily: return loc.repeatDaily;
      case RepetitionType.weekly: return loc.repeatWeekly;
      case RepetitionType.monthly: return loc.repeatMonthly;
      case RepetitionType.customDays: return loc.repeatCustomDays;
      case RepetitionType.multiplePerDay: return loc.repeatMultiplePerDay;
    }
  }

void _selectDueDate() async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2100),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith( // Use app theme
          colorScheme: ColorScheme.light(
            primary: Theme.of(context).primaryColor, // Use app primary color
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: Colors.black,
          ), dialogTheme: const DialogThemeData(backgroundColor: Colors.white),
        ),
        child: child!,
      );
    },
  );
  if (picked != null) {
    setState(() {
      _dueDate = picked;
    });
  }
}

void _selectReminderTime() async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith( // Use app theme instead of light theme
          colorScheme: ColorScheme.light(
            primary: Theme.of(context).primaryColor, // Use app primary color
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: Colors.black, // This will change AM/PM text color
          ), dialogTheme: const DialogThemeData(backgroundColor: Colors.white),
        ),
        child: child!,
      );
    },
  );
  if (picked != null) {
    setState(() {
      _reminderTime = picked;
    });
  }
}

  void _saveTask() async {
    if (_formKey.currentState!.validate()) {
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      final loc = AppLocalizations.of(context)!;
      
      final task = Task(
        id: widget.task?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        description: _descriptionController.text,
        priority: _priority,
        dueDate: _dueDate,
        reminderTime: _reminderTime,
        estimatedDuration: _estimatedDuration,
        createdAt: widget.task?.createdAt ?? DateTime.now(),
        repetition: _repetition,
      );
      
      try {
        if (widget.task == null) {
          await taskProvider.addTask(task);
        } else {
          await taskProvider.updateTask(task);
        }
        if (mounted) {
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loc.genericSaveError)),
      );
        }
      }
    }
  }

  Widget _buildPriorityButton({
    required String label,
    required String value,
    required Color color,
    required bool isSelected,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(4),
        child: Material(
          color: isSelected ? color : color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            onTap: () {
              setState(() {
                _priority = value;
              });
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
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
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}