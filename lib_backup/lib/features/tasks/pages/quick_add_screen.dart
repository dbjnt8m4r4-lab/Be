import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/color_constants.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../../../data/models/task_model.dart';

class QuickAddScreen extends StatefulWidget {
  const QuickAddScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QuickAddScreenState createState() => _QuickAddScreenState();
}

class _QuickAddScreenState extends State<QuickAddScreen> {
  final List<Map<String, dynamic>> _quickTasks = [
    {
      'title': 'الاستيقاظ المبكر',
      'priority': Priority.high,
      'duration': 0,
    },
    {
      'title': 'ممارسة الرياضة',
      'priority': Priority.high,
      'duration': 30,
    },
    {
      'title': 'قراءة كتاب',
      'priority': Priority.normal,
      'duration': 20,
    },
    {
      'title': 'التخطيط لليوم',
      'priority': Priority.high,
      'duration': 10,
    },
    {
      'title': 'تعلم شيء جديد',
      'priority': Priority.normal,
      'duration': 25,
    },
    {
      'title': 'ترتيب الغرفة',
      'priority': Priority.low,
      'duration': 15,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة سريعة'),
      ),
      body: ListView.builder(
        itemCount: _quickTasks.length,
        itemBuilder: (context, index) {
          final task = _quickTasks[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              title: Text(task['title']),
              subtitle: Text(
                'مدة مقترحة: ${task['duration']} دقيقة',
              ),
              trailing: const Icon(Icons.add),
              onTap: () {
                _addQuickTask(task);
              },
            ),
          );
        },
      ),
    );
  }

  void _addQuickTask(Map<String, dynamic> taskData) async {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    
    final task = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: taskData['title'],
      priority: taskData['priority'],
      estimatedDuration: taskData['duration'],
      createdAt: DateTime.now(),
    );
    
    await taskProvider.addTask(task);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('تم إضافة "${task.title}" بنجاح'),
          backgroundColor: ColorConstants.accentDark,
        ),
      );
      
      Navigator.pop(context);
    }
  }
}