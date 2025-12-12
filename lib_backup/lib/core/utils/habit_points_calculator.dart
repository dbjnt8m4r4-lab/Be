import '../../data/models/habit_model.dart';
import '../constants/app_constants.dart';
import 'package:flutter/material.dart';

class HabitPointsCalculator {
  // Calculate points for all habits based on their priority/weight
  static Map<String, double> calculatePoints(List<Habit> habits) {
    if (habits.isEmpty) return {};
    // Consider only active habits for daily point distribution
    final activeHabits = habits.where((h) => h.isActive).toList();
    if (activeHabits.isEmpty) return {for (var h in habits) h.id: 0.0};

    // Distribute total daily points equally among active habits
    final pointsPerHabit = AppConstants.totalDailyPoints / activeHabits.length;

    Map<String, double> pointsMap = {};
    for (var habit in habits) {
      pointsMap[habit.id] = habit.isActive ? double.parse(pointsPerHabit.toStringAsFixed(2)) : 0.0;
    }
    
    return pointsMap;
  }
  
  // Calculate daily points from completed habits
  static double calculateDailyPoints(List<Habit> completedHabits) {
    double totalPoints = 0;
    for (var habit in completedHabits) {
      totalPoints += habit.assignedPoints;
    }
    return totalPoints;
  }
  
  // Get today's completed habits
  static List<Habit> getTodayCompletedHabits(List<Habit> habits) {
    final now = DateTime.now();
    return habits.where((habit) {
      return habit.isActive &&
             habit.completedDates.any((date) => DateUtils.isSameDay(date, now));
    }).toList();
  }
  
  // Calculate total score for leaderboard: (task points + habit points) / 2
  static int calculateLeaderboardScore(double taskPoints, double habitPoints) {
    final combinedPoints = (taskPoints + habitPoints) / 2;
    return combinedPoints.toInt();
  }
}
