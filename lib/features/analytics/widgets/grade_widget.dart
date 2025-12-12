import 'package:flutter/material.dart';
import '../../../core/utils/grade_calculator.dart';
import '../../../core/constants/color_constants.dart';

class GradeWidget extends StatelessWidget {
  final String grade;
  final String title;
  final double size;

  const GradeWidget({super.key, 
    required this.grade,
    required this.title,
    this.size = 80,
  });

  @override
  Widget build(BuildContext context) {
    final gradeColor = GradeCalculator.getGradeColor(grade);
    final gradeDescription = _getGradeDescription(grade);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    color: gradeColor.withAlpha((0.1 * 255).round()),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: gradeColor,
                      width: 3,
                    ),
                  ),
                ),
                Text(
                  grade,
                  style: TextStyle(
                    fontSize: size * 0.4,
                    fontWeight: FontWeight.bold,
                    color: gradeColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              gradeDescription,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            _buildGradeProgress(grade),
          ],
        ),
      ),
    );
  }

  Widget _buildGradeProgress(String grade) {
    double progress = 0.0;
    
    switch (grade) {
      case 'A+': progress = 1.0; break;
      case 'A': progress = 0.9; break;
      case 'A-': progress = 0.85; break;
      case 'B+': progress = 0.8; break;
      case 'B': progress = 0.75; break;
      case 'B-': progress = 0.7; break;
      case 'C+': progress = 0.65; break;
      case 'C': progress = 0.6; break;
      case 'C-': progress = 0.55; break;
      case 'D+': progress = 0.5; break;
      case 'D': progress = 0.45; break;
      case 'D-': progress = 0.4; break;
      case 'F': progress = 0.2; break;
      default: progress = 0.0;
    }

    return Column(
      children: [
        LinearProgressIndicator(
          value: progress,
          backgroundColor: ColorConstants.accentLight.withAlpha((0.06 * 255).round()),
          valueColor: AlwaysStoppedAnimation<Color>(
            GradeCalculator.getGradeColor(grade),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${(progress * 100).toStringAsFixed(0)}%',
          style: const TextStyle(
            fontSize: 12,
            color: ColorConstants.accentLight,
          ),
        ),
      ],
    );
  }

  String _getGradeDescription(String grade) {
    switch (grade) {
      case 'A+': return 'أداء متميز! أنت تقوم بعمل رائع';
      case 'A': return 'أداء ممتاز، استمر في العمل الجاد';
      case 'A-': return 'أداء جيد جداً، يمكنك التحسن أكثر';
      case 'B+': return 'أداء جيد، اقتربت من التميز';
      case 'B': return 'أداء مقبول، هناك مجال للتحسن';
      case 'B-': return 'أداء متوسط، حاول التركيز أكثر';
      case 'C+': return 'أداء يحتاج للتحسين';
      case 'C': return 'أداء ضعيف، راجع استراتيجيتك';
      case 'C-': return 'أداء غير كافي، يحتاج لجهد أكبر';
      case 'D+': return 'أداء متدني، ابدأ بالتغيير الآن';
      case 'D': return 'أداء ضعيف جداً، تحتاج لإعادة تنظيم';
      case 'D-': return 'أداء غير مقبول، ابدأ من جديد';
      case 'F': return 'فشل، حان وقت التغيير الجذري';
      default: return 'لا توجد بيانات كافية';
    }
  }
}