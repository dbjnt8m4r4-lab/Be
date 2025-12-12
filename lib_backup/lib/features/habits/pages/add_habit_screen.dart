import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import '../../../data/models/habit_model.dart';
import '../../../l10n/app_localizations.dart';
import '../providers/habit_provider.dart';

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({super.key});

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  String? _selectedHabitType;
  final TextEditingController _habitNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _targetDaysController = TextEditingController();
  int? _selectedPresetDays;

  final GlobalKey _habitTypeKey = GlobalKey();
  final GlobalKey _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _habitNameController.dispose();
    _descriptionController.dispose();
    _targetDaysController.dispose();
    super.dispose();
  }

  void _setDefaultDays() {
    if (_selectedHabitType == 'kick_habit') {
      _targetDaysController.text = '90';
      _selectedPresetDays = 90;
    } else if (_selectedHabitType == 'lock_in') {
      _targetDaysController.text = '21';
      _selectedPresetDays = 21;
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    if (_selectedHabitType == null) {
      return Scaffold(
          appBar: AppBar(
            title: Text(loc.addNewHabit),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                key: _habitTypeKey,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHabitTypeCard(
                    context,
                    loc,
                    title: loc.lockIn,
                    description: loc.buildNewGoodHabit,
                    icon: Icons.lock,
                    type: 'lock_in',
                  ),
                  const SizedBox(height: 20),
                  _buildHabitTypeCard(
                    context,
                    loc,
                    title: loc.kickHabit,
                    description: loc.stopBadHabit,
                    icon: Icons.block,
                    type: 'kick_habit',
                  ),
                ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(_selectedHabitType == 'lock_in' ? loc.lockIn : loc.kickHabit),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => setState(() {
              _selectedHabitType = null;
            }),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  if (_habitNameController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(loc.pleaseEnterHabitName)),
                    );
                    return;
                  }

                  final parsedTarget = int.tryParse(_targetDaysController.text) ?? 
                      (_selectedHabitType == 'kick_habit' ? 90 : 21);
                  
                  if (parsedTarget < 10 || parsedTarget > 10000) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(loc.habitDaysRangeWarning),
                        backgroundColor: Colors.orange,
                      ),
                    );
                    return;
                  }

                  final newHabit = Habit(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: _habitNameController.text,
                    description: _descriptionController.text,
                    targetDays: parsedTarget,
                    startDate: DateTime.now(),
                    category: _selectedHabitType!,
                  );

                  context.read<HabitProvider>().addHabit(newHabit);
                  Navigator.pop(context);
                },
                child: Text(
                  loc.addHabit,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          key: _formKey,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with icon
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Icon(
                      _selectedHabitType == 'lock_in' ? Icons.lock : Icons.block,
                      size: 48,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _selectedHabitType == 'lock_in'
                          ? loc.buildNewGoodHabit
                          : loc.stopBadHabit,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Habit Name
              Text(
                loc.habitNameTitle,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _habitNameController,
                decoration: InputDecoration(
                  labelText: _selectedHabitType == 'lock_in'
                      ? loc.habitNameExample1
                      : loc.habitNameExample2,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),

              const SizedBox(height: 28),

              // Describe Your Goal
              Text(
                loc.describeGoalTitle,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(16),
                    border: InputBorder.none,
                    hintText: loc.habitGoalHint,
                  ),
                  maxLines: 5,
                  maxLength: 500,
                ),
              ),

              const SizedBox(height: 28),

              // Target Days
              Text(
                loc.specifyDaysTitle,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),

              // Quick presets for target days
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  // Show different presets based on habit type
                  if (_selectedHabitType == 'lock_in') ...[21, 30, 60, 90].map((d) {
                    final selected = _selectedPresetDays == d;
                    return ChoiceChip(
                      label: Text(loc.daysCount(d)),
                      selected: selected,
                      onSelected: (sel) {
                        setState(() {
                          _selectedPresetDays = sel ? d : null;
                          if (sel) _targetDaysController.text = d.toString();
                        });
                      },
                    );
                  }),
                  if (_selectedHabitType == 'kick_habit') ...[90, 120, 180, 365].map((d) {
                    final selected = _selectedPresetDays == d;
                    return ChoiceChip(
                      label: Text(loc.daysCount(d)),
                      selected: selected,
                      onSelected: (sel) {
                        setState(() {
                          _selectedPresetDays = sel ? d : null;
                          if (sel) _targetDaysController.text = d.toString();
                        });
                      },
                    );
                  }),
                ],
              ),
              const SizedBox(height: 16),

              // Custom days input
              TextFormField(
                controller: _targetDaysController,
                keyboardType: TextInputType.number,
                maxLength: 4,
                onChanged: (v) {
                  final parsed = int.tryParse(v);
                  setState(() {
                    _selectedPresetDays = parsed;
                  });
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  counterText: '',
                  labelText: loc.numberOfDaysLabel,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: _setDefaultDays,
                    tooltip: loc.setDefaultDays,
                  ),
                ),
              ),

              const SizedBox(height: 120),
            ],
        ),
      ),
    );
  }

  Widget _buildHabitTypeCard(
    BuildContext context,
    AppLocalizations loc, {
    required String title,
    required String description,
    required IconData icon,
    required String type,
  }) {
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedHabitType = type;
            _setDefaultDays();
          });
        },
        child: Card(
          elevation: 4,
          child: Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: 56,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}