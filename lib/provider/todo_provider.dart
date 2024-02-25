import 'package:flutter/foundation.dart';
import 'package:todo_app/data/model/todo.dart';
import 'package:todo_app/data/repositories/todo_repository.dart';

class TodoProvider extends ChangeNotifier {
  final TodoRepository repository;

  TodoProvider({required this.repository}) {
    fetchTodos();
  }
  
  List<Todo> _todos = [];
  List<Todo> get todos => _todos;


  Future<void> fetchTodos() async {
    _todos = await repository.fetchTodos();
    notifyListeners();
  }

  Future<void> addTodo(Todo todo) async {
    await repository.addTodo(todo);
    fetchTodos();
  }

  Future<void> updateTodoStatus(int id, bool isCompleted) async {
    await repository.updateTodoStatus(id, isCompleted);
    fetchTodos();
  }

  Future<void> deleteTodo(Todo todo) async {
    await repository.deleteTodo(todo.id);
    fetchTodos();
  }
}
