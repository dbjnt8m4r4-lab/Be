import 'package:flutter/material.dart';
import '../../../data/models/habit_model.dart';
import '../../../l10n/app_localizations.dart';
import '../widgets/streak_counter.dart';
import '../widgets/progress_chart.dart';

class HabitProgressScreen extends StatefulWidget {
  final Habit habit;

  const HabitProgressScreen({super.key, required this.habit});

  @override
  State<HabitProgressScreen> createState() => _HabitProgressScreenState();
}

class _HabitProgressScreenState extends State<HabitProgressScreen> {
  final GlobalKey _progressKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final today = DateTime.now();
    final daysSinceStart = today.difference(widget.habit.startDate).inDays;
    final isNewHabit = widget.habit.completedDates.isEmpty || (daysSinceStart <= 2 && widget.habit.currentStreak == 0);

    // Calculate progress data for the chart
    final progressData = List.generate(widget.habit.targetDays, (index) {
      final date = widget.habit.startDate.add(Duration(days: index));
      final isCompleted = widget.habit.completedDates.any((d) => 
          d.year == date.year && d.month == date.month && d.day == date.day);
      return {
        'date': date,
        'completed': isCompleted,
        'dayNumber': index + 1,
      };
    });

    return Scaffold(
        appBar: AppBar(
          title: Text(loc.habitProgressTitle ?? 'Habit Progress'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Performance Scale/Header
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.habit.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Chip(
                            label: Text(
                              widget.habit.category == 'lock_in' ? loc.lockIn : loc.kickHabit,
                              style: TextStyle(
                                color: widget.habit.category == 'lock_in' 
                                    ? Colors.white 
                                    : Colors.black,
                                fontSize: 12,
                              ),
                            ),
                            backgroundColor: widget.habit.category == 'lock_in' 
                                ? Colors.black 
                                : Colors.white,
                            side: widget.habit.category == 'kick_habit' 
                                ? const BorderSide(color: Colors.black, width: 1)
                                : null,
                          ),
                          const SizedBox(width: 8),
                          Chip(
                            label: Text(
                              'Started: ${_formatDate(widget.habit.startDate)}',
                              style: const TextStyle(fontSize: 12),
                            ),
                            backgroundColor: Colors.grey[200],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Streak Counter
              StreakCounter(
                currentStreak: widget.habit.currentStreak,
                longestStreak: widget.habit.longestStreak,
                targetDays: widget.habit.targetDays,
              ),

              const SizedBox(height: 16),

              // Progress Chart
              ProgressChart(
                progressData: progressData,
                habitName: widget.habit.name,
              ),

              const SizedBox(height: 16),

              // Detailed Day-by-Day Analysis
              Card(
                key: _progressKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Detailed Progress',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Statistics
                      _buildStatistics(context, loc),
                      
                      const SizedBox(height: 16),
                      
                      // Day-by-day list
                      _buildDayByDayList(progressData),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }

  Widget _buildStatistics(BuildContext context, AppLocalizations loc) {
    final completedCount = widget.habit.completedDates.length;
    final completionRate = widget.habit.targetDays > 0 
        ? (completedCount / widget.habit.targetDays) * 100 
        : 0;
    final daysRemaining = widget.habit.targetDays - completedCount;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatItem('Completed', '$completedCount/${widget.habit.targetDays}', Icons.check_circle, Colors.green),
        _buildStatItem('Rate', '${completionRate.toStringAsFixed(1)}%', Icons.trending_up, Colors.blue),
        _buildStatItem('Remaining', '$daysRemaining days', Icons.schedule, Colors.orange),
      ],
    );
  }

  Widget _buildStatItem(String title, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildDayByDayList(List<Map<String, dynamic>> progressData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Day-by-Day Progress:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 200,
          child: ListView.builder(
            itemCount: progressData.length,
            itemBuilder: (context, index) {
              final dayData = progressData[index];
              final date = dayData['date'] as DateTime;
              final isCompleted = dayData['completed'] as bool;
              final dayNumber = dayData['dayNumber'] as int;
              
              return ListTile(
                leading: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: isCompleted ? Colors.green : Colors.grey[200],
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '$dayNumber',
                      style: TextStyle(
                        color: isCompleted ? Colors.white : Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                title: Text('Day $dayNumber - ${_formatDate(date)}'),
                subtitle: Text(isCompleted ? 'Completed' : 'Not completed'),
                trailing: Icon(
                  isCompleted ? Icons.check : Icons.close,
                  color: isCompleted ? Colors.green : Colors.grey,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}