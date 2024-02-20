import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/util/todo_tile.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List todo_list = [
    ['Task 1', false],
    ['Task 2', false],
    ['Task 3', false],
    ['Task 4', false],
    ['Task 5', false],
    ['Task 6', false],
    ['Task 7', false],
    ['Task 8', false],
    ['Task 9', false],
  ];

  void onCheckboxChanged(bool? value, int index) {
    setState(() {
      todo_list[index][1] = !todo_list[index][1];
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    final formattedDate = DateFormat('EEEE, dd MMMM yyyy').format(currentDate);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          formattedDate,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome RISTEK',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'You have 9 tasks',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Daily Task',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    child: ElevatedButton(
                      onPressed: () {
                        // Add task logic here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                      ),
                      child: const Text(
                        'Add Task',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: todo_list.length,
                itemBuilder: (context, index) {
                  return TodoTile(
                    taskName: todo_list[index][0],
                    isTaskCompleted: todo_list[index][1],
                    onCheckboxChanged: (value) =>
                        onCheckboxChanged(value, index),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
