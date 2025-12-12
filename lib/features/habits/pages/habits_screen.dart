import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../l10n/app_localizations.dart';
import '../providers/habit_provider.dart';
import '../widgets/habit_card.dart';
import '../widgets/habit_points_indicator.dart';
import 'add_habit_screen.dart';
import 'habit_progress_screen.dart';

class HabitsScreen extends StatefulWidget {
  const HabitsScreen({super.key});

  @override
  State<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  final GlobalKey _addHabitButtonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        title: Text(
          loc.habits ?? 'Habits',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Consumer<HabitProvider>(
        builder: (context, habitProvider, child) {
          // Set context only once, not on every build
          WidgetsBinding.instance.addPostFrameCallback((_) {
            habitProvider.setContext(context);
          });
          final habits = habitProvider.habits;

          if (habits.isEmpty) {
            // First time: clean page with centered “Add Habits” button, no scale
            return _buildEmptyState(context, loc);
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: HabitPointsIndicator(habits: habits),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  itemCount: habits.length,
                  itemBuilder: (context, index) {
                    final habit = habits[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HabitProgressScreen(habit: habit),
                        ),
                      ),
                      child: HabitCard(
                        key: ValueKey(habit.id),
                        habit: habit,
                        onEdit: () {
                          // TODO: Implement edit functionality
                        },
                        onToggle: () {
                          habitProvider.markHabitCompleted(habit.id);
                        },
                        onDelete: () => habitProvider.deleteHabit(habit.id),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Consumer<HabitProvider>(
        builder: (context, habitProvider, _) {
          if (habitProvider.habits.isEmpty) {
            return const SizedBox.shrink();
          }
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: SizedBox(
                height: 48,
                child: ElevatedButton.icon(
                  key: _addHabitButtonKey,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddHabitScreen()),
                  ),
                  icon: const Icon(Icons.add),
                  label: Text(loc.addHabitsButton ?? loc.addHabit ?? 'Add Habits'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, AppLocalizations loc) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDark ? Colors.white.withAlpha(76) : Colors.black.withAlpha(76);
    final textColor = isDark ? Colors.white.withAlpha(178) : Colors.black.withAlpha(178);
    final secondaryTextColor = isDark ? Colors.white.withAlpha(127) : Colors.black.withAlpha(127);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.track_changes,
            size: 80,
            color: iconColor,
          ),
          const SizedBox(height: 24),
          Text(
            loc.noHabitsYet ?? 'No Habits Yet',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: textColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            loc.createFirstHabit ?? 'Create your first habit to get started',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: secondaryTextColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Center(
            child: SizedBox(
              width: 220,
              child: ElevatedButton.icon(
                key: _addHabitButtonKey,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddHabitScreen()),
                ),
                icon: const Icon(Icons.add),
                label: Text(loc.addHabitsButton ?? loc.addHabit ?? 'Add Habits'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}