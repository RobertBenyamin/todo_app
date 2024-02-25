import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/add_todo.dart';
import 'package:todo_app/data/model/todo.dart';
import 'package:todo_app/widgets/todo_tile.dart';
import 'package:todo_app/provider/todo_provider.dart';
import 'package:todo_app/utils/date_time_helper.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          DateTimeHelper.formatCurrentDate(),
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
              Consumer<TodoProvider>(
                builder: (context, provider, _) {
                  return Text(
                    'You have ${provider.unfinishedTodos.isEmpty ? 'no' : '${provider.unfinishedTodos.length}'} '
                    '${provider.unfinishedTodos.length <= 1 ? 'task' : 'tasks'}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  );
                },
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider.value(
                              value: context.read<TodoProvider>(),
                              child: const AddTodoPage(),
                            ),
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
              Consumer<TodoProvider>(
                builder: (context, state, _) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.todos.length,
                    itemBuilder: (context, index) {
                      Todo todo = state.todos[index];
                      return TodoTile(
                        taskName: todo.title,
                        deadline: DateTimeHelper.formatDateTime(todo.endDate),
                        isTaskCompleted: todo.isFinished,
                        onCheckboxChanged: (value) => {
                          context
                              .read<TodoProvider>()
                              .updateTodoStatus(todo.id, value!),
                        },
                        deleteFunction: (context) {
                          context.read<TodoProvider>().deleteTodo(todo);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Task deleted'),
                            ),
                          );
                        },
                      );
                    },
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
