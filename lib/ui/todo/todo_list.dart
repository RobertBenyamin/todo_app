import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'package:todo_app/provider/profile_provider.dart';
import 'package:todo_app/ui/todo/add_todo.dart';
import 'package:todo_app/ui/todo/edit_todo.dart';
import 'package:todo_app/ui/todo/detail_todo.dart';
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
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    context.read<TodoProvider>().filterTasks("");
  }

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
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.flatColored,
      title: const Text('Task deleted'),
      alignment: Alignment.bottomCenter,
      closeButtonShowType: CloseButtonShowType.none,
      showProgressBar: false,
      autoCloseDuration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 300),
      borderRadius: BorderRadius.circular(12.0),
    );
  }

  void filterTask(BuildContext context, String searchText) {
    context.read<TodoProvider>().filterTasks(searchText);
    if (context.read<TodoProvider>().unfinishedPriorityTodos.isEmpty &&
        context.read<TodoProvider>().unfinishedNonPriorityTodos.isEmpty) {
      toastification.show(
        context: context,
        type: ToastificationType.error,
        style: ToastificationStyle.flatColored,
        title: const Text('No task found'),
        alignment: Alignment.bottomCenter,
        closeButtonShowType: CloseButtonShowType.none,
        showProgressBar: false,
        autoCloseDuration: const Duration(seconds: 3),
        animationDuration: const Duration(milliseconds: 300),
        borderRadius: BorderRadius.circular(12.0),
      );
    }
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
                Text(
                  'Welcome ${Provider.of<ProfileProvider>(context).name}',
                  style: const TextStyle(
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
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search Task',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) {
                    filterTask(context, _searchController.text);
                  },
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
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FittedBox(
          child: FloatingActionButton(
            tooltip: "Add Task",
            backgroundColor: const Color(0xFF5038BC),
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
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
