import 'package:flutter/material.dart';
import 'package:todo_app/utils/date_time_helper.dart';

class CustomTimeField extends StatefulWidget {
  final TextEditingController timeController;
  final bool isEnable;

  const CustomTimeField({
    super.key,
    required this.timeController,
    required this.isEnable,
  });

  @override
  State<CustomTimeField> createState() => _CustomTimeFieldState();
}

class _CustomTimeFieldState extends State<CustomTimeField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.timeController,
      enabled: widget.isEnable,
      readOnly: true,
      style: const TextStyle(
        color: Colors.black,
      ),
      decoration: InputDecoration(
        prefixIcon: GestureDetector(
            onTap: () {
              showTimePicker(
                context: context,
                initialTime: DateTimeHelper.timeNow,
              ).then((selectedTime) {
                if (selectedTime != null) {
                  DateTime selectedDateTime = DateTime(
                    DateTimeHelper.dateNow.year,
                    DateTimeHelper.dateNow.month,
                    DateTimeHelper.dateNow.day,
                    selectedTime.hour,
                    selectedTime.minute,
                  );
                  widget.timeController.text =
                      DateTimeHelper.formatTime(selectedDateTime);
                }
              });
            },
            child: const Icon(Icons.access_time, color: Colors.deepPurple)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
