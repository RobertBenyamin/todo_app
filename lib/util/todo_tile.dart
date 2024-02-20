import 'package:flutter/material.dart';

class TodoTile extends StatefulWidget {
  final String taskName;
  final bool isTaskCompleted;
  final Function(bool?)? onCheckboxChanged;

  const TodoTile(
      {super.key,
      required this.taskName,
      required this.isTaskCompleted,
      required this.onCheckboxChanged});

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey), // Add this line
        ),
        child: Row(
          children: [
            Checkbox(
                value: widget.isTaskCompleted,
                onChanged: widget.onCheckboxChanged),
            const SizedBox(width: 16),
            Text(
              widget.taskName,
              style: TextStyle(
                  decoration: widget.isTaskCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
            ),
          ],
        ),
      ),
    );
  }
}
