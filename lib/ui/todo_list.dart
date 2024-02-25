import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/add_todo.dart';
import 'package:todo_app/ui/edit_todo.dart';
import 'package:todo_app/ui/detail_todo.dart';
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
                  'You have ${provider.unfinishedTodos.isEmpty ? 'no' : '${provider.unfinishedTodos.length}'} '
                  '${provider.unfinishedTodos.length <= 1 ? 'task' : 'tasks'}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                if (provider.unfinishedPriorityTodos.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Priority Task',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: provider.unfinishedPriorityTodos.length,
                        itemBuilder: (context, index) {
                          Todo todo = provider.unfinishedPriorityTodos[index];
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
                const SizedBox(height: 16),
                if (provider.unfinishedNonPriorityTodos.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Non Priority Task',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: provider.unfinishedNonPriorityTodos.length,
                        itemBuilder: (context, index) {
                          Todo todo =
                              provider.unfinishedNonPriorityTodos[index];
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
      // Dummy Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add Task",
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 400),
              pageBuilder: (context, animation, secondaryAnimation) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).animate(animation),
                  child: ChangeNotifierProvider.value(
                    value: context.read<TodoProvider>(),
                    child: const AddTodoPage(),
                  ),
                );
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
