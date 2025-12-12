import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/analytics_provider.dart';
import '../../../core/constants/color_constants.dart';
import '../../../l10n/app_localizations.dart';
import '../widgets/points_chart.dart';
import '../widgets/grade_widget.dart';
import '../widgets/consistency_graph.dart';
import '../../../data/models/analytics_model.dart';

class MonthlyAnalyticsScreen extends StatefulWidget {
  const MonthlyAnalyticsScreen({super.key});

  @override
  _MonthlyAnalyticsScreenState createState() => _MonthlyAnalyticsScreenState();
}

class _MonthlyAnalyticsScreenState extends State<MonthlyAnalyticsScreen> {
  int _selectedMonth = DateTime.now().month;
  int _selectedYear = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.monthlyAnalytics),
      ),
      body: Consumer<AnalyticsProvider>(
        builder: (context, analyticsProvider, child) {
          if (analyticsProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final monthlyAnalytics = analyticsProvider.currentMonthlyAnalytics;
          if (monthlyAnalytics == null) {
            return Center(child: Text(loc.noAnalyticsData));
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildMonthSelector(loc),
              const SizedBox(height: 24),
              _buildMonthlySummary(loc, monthlyAnalytics),
              const SizedBox(height: 24),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: PointsChart(dailyPointsData: analyticsProvider.getDailyPointsData()),
                ),
              ),
              const SizedBox(height: 16),
              GradeWidget(
                grade: monthlyAnalytics.consistencyGrade,
                title: loc.monthlyRatingTitle,
              ),
              const SizedBox(height: 24),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ConsistencyGraph(
                    consistencyData: {
                      'currentStreak': monthlyAnalytics.successfulDays,
                      'longestStreak': _calculateLongestStreak(monthlyAnalytics),
                      'successRate': monthlyAnalytics.successRate,
                    },
                    consistencyHistory: analyticsProvider.getConsistencyHistory(),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildDailyBreakdown(loc, monthlyAnalytics),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMonthSelector(AppLocalizations loc) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                setState(() {
                  _selectedMonth--;
                  if (_selectedMonth < 1) {
                    _selectedMonth = 12;
                    _selectedYear--;
                  }
                });
              },
            ),
            Expanded(
              child: Text(
                '${_getMonthName(loc, _selectedMonth)} $_selectedYear',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios_rounded),
              onPressed: () {
                setState(() {
                  _selectedMonth++;
                  if (_selectedMonth > 12) {
                    _selectedMonth = 1;
                    _selectedYear++;
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlySummary(AppLocalizations loc, MonthlyAnalytics analytics) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.monthSummaryTitle,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSummaryItem(loc.successfulDaysLabel, '${analytics.successfulDays}'),
                _buildSummaryItem(loc.totalDaysLabel, '${analytics.totalDays}'),
                _buildSummaryItem(loc.averagePointsLabel, analytics.averagePoints.toStringAsFixed(1)),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: analytics.successRate,
              minHeight: 10,
              backgroundColor: ColorConstants.accentLight.withOpacity(.15),
              valueColor: AlwaysStoppedAnimation<Color>(
                analytics.successRate >= 0.7 ? ColorConstants.accentDark : ColorConstants.accentMid,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${loc.successRateLabel}: ${(analytics.successRate * 100).toStringAsFixed(1)}%',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ColorConstants.secondaryColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildDailyBreakdown(AppLocalizations loc, MonthlyAnalytics analytics) {
    final entries = analytics.dailyData.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.dailyBreakdownTitle,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: entries.length,
              separatorBuilder: (_, __) => const Divider(height: 20),
              itemBuilder: (context, index) {
                final entry = entries[index];
                final date = entry.key;
                final data = entry.value;
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: data.isSuccessfulDay ? ColorConstants.accentDark : ColorConstants.accentLight,
                    child: Icon(
                      data.isSuccessfulDay ? Icons.check : Icons.close,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                  title: Text('${date.day}/${date.month}/${date.year}'),
                  subtitle: Text(
                    loc.pointsAndGrade(
                      data.pointsEarned.toStringAsFixed(1),
                      data.grade,
                    ),
                  ),
                  trailing: Text(
                    loc.tasksProgressCount(
                      data.tasksCompleted,
                      data.totalTasks,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String _getMonthName(AppLocalizations loc, int month) {
    final englishMonths = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    final arabicMonths = [
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];

    return loc.localeName == 'ar' ? arabicMonths[month - 1] : englishMonths[month - 1];
  }

  int _calculateLongestStreak(MonthlyAnalytics analytics) {
    int longestStreak = 0;
    int currentStreak = 0;

    final dates = analytics.dailyData.keys.toList()..sort();

    for (final date in dates) {
      final data = analytics.dailyData[date];
      if (data != null && data.isSuccessfulDay) {
        currentStreak++;
        if (currentStreak > longestStreak) {
          longestStreak = currentStreak;
        }
      } else {
        currentStreak = 0;
      }
    }

    return longestStreak;
  }
}