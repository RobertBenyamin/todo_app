import 'package:isar/isar.dart';
import 'package:todo_app/data/model/todo.dart';
import 'package:path_provider/path_provider.dart';

class TodoRepository {
  static late Isar isar;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [TodoSchema],
      directory: dir.path,
    );
  }

  Future<void> addTodo(Todo newTodo) async {
    await isar.writeTxn(() async {
      await isar.todos.put(newTodo);
    });
  }

  Future<List<Todo>> fetchTodos() async {
    return await isar.todos.where().sortByEndDate().findAll();
  }

  Future<List<Todo>> fetchUnfinishedTodos() async {
    var priorityTodos = await fetchUnfinishedPriorityTodos();
    var otherTodos = await fetchUnfinishedNonPriorityTodos();
    return [...priorityTodos, ...otherTodos];
  }

  Future<List<Todo>> fetchUnfinishedPriorityTodos() async {
    return await isar.todos
        .where()
        .filter()
        .isFinishedEqualTo(false)
        .isPriorityEqualTo(true)
        .sortByEndDate()
        .findAll();
  }

  Future<List<Todo>> fetchUnfinishedNonPriorityTodos() async {
    return await isar.todos
        .where()
        .filter()
        .isFinishedEqualTo(false)
        .isPriorityEqualTo(false)
        .sortByEndDate()
        .findAll();
  }

  Future<List<Todo>> fetchFinishedTodos() async {
    return await isar.todos
        .where()
        .filter()
        .isFinishedEqualTo(true)
        .sortByEndDateDesc()
        .findAll();
  }

  Future<void> updateTodo(Todo newTodo) async {
    final oldTodo = await isar.todos.where().idEqualTo(newTodo.id).findFirst();
    if (oldTodo != null) {
      oldTodo
        ..startDate = newTodo.startDate
        ..endDate = newTodo.endDate
        ..title = newTodo.title
        ..isPriority = newTodo.isPriority
        ..isDaily = newTodo.isDaily
        ..description = newTodo.description
        ..isFinished = newTodo.isFinished;
      await isar.writeTxn(() async {
        await isar.todos.put(oldTodo);
      });
    }
  }

  Future<void> deleteTodo(int id) async {
    await isar.writeTxn(() async {
      await isar.todos.delete(id);
    });
  }

  Future<void> updateTodoStatus(int id, bool isFinished) async {
    final todo = await isar.todos.where().idEqualTo(id).findFirst();
    if (todo != null) {
      todo.isFinished = isFinished;
      await isar.writeTxn(() async {
        await isar.todos.put(todo);
      });
    }
  }
}
