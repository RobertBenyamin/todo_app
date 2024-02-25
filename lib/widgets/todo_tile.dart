import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatefulWidget {
  final String taskName;
  final String deadline;
  final bool isTaskCompleted;
  final Function(bool?)? onCheckboxChanged;
  final Function()? onLongPress;
  final Function(BuildContext)? editFunction;
  final Function(BuildContext)? deleteFunction;

  const TodoTile(
      {super.key,
      required this.taskName,
      required this.deadline,
      required this.isTaskCompleted,
      required this.onCheckboxChanged,
      required this.onLongPress,
      required this.editFunction,
      required this.deleteFunction});

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: widget.editFunction,
              borderRadius: BorderRadius.circular(8),
              backgroundColor: Colors.blue,
              icon: Icons.edit,
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: widget.deleteFunction,
              borderRadius: BorderRadius.circular(8),
              backgroundColor: Colors.red,
              icon: Icons.delete,
            ),
          ],
        ),
        child: GestureDetector(
          onLongPress: widget.onLongPress,
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
        ),
      ),
    );
  }
}
