import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/detail_todo.dart';
import 'package:todo_app/ui/edit_todo.dart';
import 'package:todo_app/data/model/todo.dart';
import 'package:todo_app/widgets/todo_tile.dart';
import 'package:todo_app/provider/todo_provider.dart';
import 'package:todo_app/utils/date_time_helper.dart';

class FinishedTodoPage extends StatefulWidget {
  const FinishedTodoPage({Key? key}) : super(key: key);

  @override
  State<FinishedTodoPage> createState() => _FinishedTodoPageState();
}

class _FinishedTodoPageState extends State<FinishedTodoPage> {
  void onLongPress(BuildContext context, Todo todo) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, animation, secondaryAnimation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: ChangeNotifierProvider.value(
              value: context.read<TodoProvider>(),
              child: DetailTodoPage(todo: todo),
            ),
          );
        },
      ),
    );
  }

  void editFunction(BuildContext context, Todo todo) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, animation, secondaryAnimation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: ChangeNotifierProvider.value(
              value: context.read<TodoProvider>(),
              child: EditTodoPage(todo: todo),
            ),
          );
        },
      ),
    );
  }

  void deleteFunction(BuildContext context, Todo todo) {
    context.read<TodoProvider>().deleteTodo(todo);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Task deleted'),
      ),
    );
  }

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
      body: Consumer<TodoProvider>(builder: (context, provider, _) {
        return SingleChildScrollView(
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
                Text(
                  'You have ${provider.finishedTodos.isEmpty ? 'no' : '${provider.finishedTodos.length}'} finished '
                  '${provider.finishedTodos.length <= 1 ? 'task' : 'tasks'}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                if (provider.finishedTodos.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Finished Task',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: provider.finishedTodos.length,
                        itemBuilder: (context, index) {
                          Todo todo = provider.finishedTodos[index];
                          return TodoTile(
                            taskName: todo.title,
                            deadline:
                                DateTimeHelper.formatDateTime(todo.endDate),
                            isTaskCompleted: todo.isFinished,
                            onLongPress: () => onLongPress(context, todo),
                            onCheckboxChanged: (value) => {
                              context
                                  .read<TodoProvider>()
                                  .updateTodoStatus(todo.id, value!),
                            },
                            editFunction: (context) =>
                                editFunction(context, todo),
                            deleteFunction: (context) =>
                                deleteFunction(context, todo),
                          );
                        },
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
