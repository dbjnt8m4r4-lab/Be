import 'package:flutter/material.dart';
import '../../../data/models/task_model.dart';

class RepetitionSelector extends StatefulWidget {
  final Repetition? initialRepetition;
  final Function(Repetition?) onRepetitionChanged;

  const RepetitionSelector({
    super.key,
    this.initialRepetition,
    required this.onRepetitionChanged,
  });

  @override
  State<RepetitionSelector> createState() => _RepetitionSelectorState();
}

class _RepetitionSelectorState extends State<RepetitionSelector> {
  late RepetitionType _type;
  int _interval = 1;
  int _targetCount = 1;
  List<int> _daysOfWeek = [];
  
  @override
  void initState() {
    super.initState();
    if (widget.initialRepetition != null) {
      _type = widget.initialRepetition!.type;
      _interval = widget.initialRepetition!.interval ?? 1;
      _targetCount = widget.initialRepetition!.targetCount;
      _daysOfWeek = widget.initialRepetition!.daysOfWeek ?? [];
    } else {
      _type = RepetitionType.none;
    }
  }

  void _updateRepetition() {
    if (_type == RepetitionType.none) {
      widget.onRepetitionChanged(null);
      return;
    }

    widget.onRepetitionChanged(Repetition(
      type: _type,
      interval: _type == RepetitionType.customDays ? _interval : null,
      daysOfWeek: _type == RepetitionType.weekly ? _daysOfWeek : null,
      targetCount: _type == RepetitionType.multiplePerDay ? _targetCount : 1,
    ));
  }

  @override
  Widget build(BuildContext context) {
    // Note: Localizations for new strings might be missing, using fallbacks
    // In a real app, we should add these to AppLocalizations
    
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Repeat Task',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          // Type Selector
          DropdownButtonFormField<RepetitionType>(
            initialValue: _type,
            decoration: const InputDecoration(
              labelText: 'Frequency',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: RepetitionType.none, child: Text('Does not repeat')),
              DropdownMenuItem(value: RepetitionType.daily, child: Text('Every day')),
              DropdownMenuItem(value: RepetitionType.customDays, child: Text('Every X days')),
              DropdownMenuItem(value: RepetitionType.weekly, child: Text('Weekly')),
              DropdownMenuItem(value: RepetitionType.monthly, child: Text('Monthly')),
              DropdownMenuItem(value: RepetitionType.multiplePerDay, child: Text('Multiple times per day')),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _type = value;
                  _updateRepetition();
                });
              }
            },
          ),
          
          const SizedBox(height: 16),
          
          // Custom Days Interval
          if (_type == RepetitionType.customDays)
            Row(
              children: [
                const Text('Every '),
                SizedBox(
                  width: 60,
                  child: TextFormField(
                    initialValue: _interval.toString(),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      final val = int.tryParse(value);
                      if (val != null && val > 0) {
                        setState(() {
                          _interval = val;
                          _updateRepetition();
                        });
                      }
                    },
                  ),
                ),
                const Text(' days'),
              ],
            ),

          // Weekly Selector
          if (_type == RepetitionType.weekly)
            Wrap(
              spacing: 8,
              children: List.generate(7, (index) {
                final dayIndex = index + 1;
                final isSelected = _daysOfWeek.contains(dayIndex);
                final dayName = ['M', 'T', 'W', 'T', 'F', 'S', 'S'][index];
                
                return FilterChip(
                  label: Text(dayName),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _daysOfWeek.add(dayIndex);
                      } else {
                        _daysOfWeek.remove(dayIndex);
                      }
                      _daysOfWeek.sort();
                      _updateRepetition();
                    });
                  },
                );
              }),
            ),

          // Multiple Times Per Day
          if (_type == RepetitionType.multiplePerDay)
            Row(
              children: [
                const Text('Repeat '),
                SizedBox(
                  width: 60,
                  child: TextFormField(
                    initialValue: _targetCount.toString(),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      final val = int.tryParse(value);
                      if (val != null && val > 0) {
                        setState(() {
                          _targetCount = val;
                          _updateRepetition();
                        });
                      }
                    },
                  ),
                ),
                const Text(' times per day'),
              ],
            ),
            
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Done'),
            ),
          ),
        ],
      ),
    );
  }
}
