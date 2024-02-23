import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/ui/add_todo.dart';
import 'package:todo_app/widgets/todo_tile.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List todoList = [
    ['Task 1', '28 Feb 2024', false],
    ['Task 2', '2 Mar 2024', false],
    ['Task 3', '2 Mar 2024', false],
    ['Task 4', '3 Mar 2024', false],
    ['Task 5', '7 Mar 2024', false],
    ['Task 6', '12 Mar 2024', false],
    ['Task 7', '20 Mar 2024', false],
    ['Task 8', '1 Apr 2024', false],
    ['Task 9', '6 Apr 2024', false],
  ];

  void onCheckboxChanged(bool? value, int index) {
    setState(() {
      todoList[index][2] = !todoList[index][2];
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddTodoPage(),
                          ),
                        );
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
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  return TodoTile(
                    taskName: todoList[index][0],
                    deadline: todoList[index][1],
                    isTaskCompleted: todoList[index][2],
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
