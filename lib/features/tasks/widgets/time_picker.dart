import 'package:flutter/material.dart';

class TimePicker extends StatelessWidget {
  final TimeOfDay? selectedTime;
  final Function(TimeOfDay) onTimeSelected;
  final String label;

  const TimePicker({super.key, 
    required this.selectedTime,
    required this.onTimeSelected,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.access_time),
      title: Text(label),
      subtitle: Text(
        selectedTime != null
            ? '${selectedTime!.hour}:${selectedTime!.minute.toString().padLeft(2, '0')}'
            : 'لم يتم تحديد وقت',
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () async {
        final TimeOfDay? picked = await showTimePicker(
          context: context,
          initialTime: selectedTime ?? TimeOfDay.now(),
        );
        if (picked != null) {
          onTimeSelected(picked);
        }
      },
    );
  }
}