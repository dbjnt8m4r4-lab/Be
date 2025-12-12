import 'package:flutter/material.dart';
import '../constants/color_constants.dart';

class GradeCalculator {
  static String calculateGrade(double points) {
    if (points >= 95) return 'A+';
    if (points >= 90) return 'A';
    if (points >= 85) return 'A-';
    if (points >= 80) return 'B+';
    if (points >= 75) return 'B';
    if (points >= 70) return 'B-';
    if (points >= 65) return 'C+';
    if (points >= 60) return 'C';
    if (points >= 55) return 'C-';
    if (points >= 50) return 'D+';
    if (points >= 45) return 'D';
    if (points >= 40) return 'D-';
    return 'F';
  }
  
  static String calculateMonthlyGrade(double successRate) {
    double percentage = successRate * 100;
    
    if (percentage >= 90) return 'A+';
    if (percentage >= 80) return 'A';
    if (percentage >= 70) return 'B+';
    if (percentage >= 60) return 'B';
    if (percentage >= 50) return 'C+';
    if (percentage >= 40) return 'C';
    if (percentage >= 30) return 'D';
    return 'F';
  }
  
  static Color getGradeColor(String grade) {
    switch (grade) {
      case 'A+':
      case 'A':
      case 'A-':
        return ColorConstants.priorityLow; // Green
      case 'B+':
      case 'B':
      case 'B-':
        return ColorConstants.priorityNormal; // Yellow
      case 'C+':
      case 'C':
      case 'C-':
        return ColorConstants.priorityHigh; // Red
      case 'D+':
      case 'D':
      case 'D-':
        return ColorConstants.priorityHigh; // Red
      case 'F':
        return ColorConstants.priorityHigh; // Red
      default:
        return ColorConstants.priorityNormal; // Yellow
    }
  }
}