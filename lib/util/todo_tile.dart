import 'package:flutter/material.dart';

class TodoTile extends StatefulWidget {
  final String taskName;
  final String deadline;
  final bool isTaskCompleted;
  final Function(bool?)? onCheckboxChanged;

  const TodoTile(
      {super.key,
      required this.taskName,
      required this.deadline,
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
        decoration: BoxDecoration(
          border: Border.all(color: Colors.deepPurple),
          borderRadius: BorderRadius.circular(8),
        ),
        child: CheckboxListTile(
          title: Text(widget.taskName),
          subtitle: Text(widget.deadline),
          value: widget.isTaskCompleted,
          tileColor: widget.isTaskCompleted ? Colors.grey.shade300 : null,
          onChanged: widget.onCheckboxChanged,
          controlAffinity: ListTileControlAffinity.leading,
        ),
      ),
    );
  }
}
