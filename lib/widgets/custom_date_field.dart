import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateField extends StatefulWidget {
  final TextEditingController textController;
  final bool isEnable;
  final String title;
  final String content;

  const CustomDateField(
      {super.key,
      required this.textController,
      required this.isEnable,
      required this.title,
      required this.content});

  @override
  State<CustomDateField> createState() => _CustomDateFieldState();
}

class _CustomDateFieldState extends State<CustomDateField> {
  @override
  void initState() {
    super.initState();
    widget.textController.text = widget.content;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: widget.textController,
          enabled: widget.isEnable,
          readOnly: true,
          style: const TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            prefixIcon: GestureDetector(
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2022),
                    lastDate: DateTime(2025),
                  ).then((value) {
                    if (value != null) {
                      String formattedDate =
                          DateFormat('dd MMM yyyy').format(value);
                      widget.textController.text = formattedDate;
                    }
                  });
                },
                child:
                    const Icon(Icons.calendar_today, color: Colors.deepPurple)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}