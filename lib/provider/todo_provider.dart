import 'dart:async';

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

  List<Todo> _finishedTodos = [];
  List<Todo> get finishedTodos => _finishedTodos;

  List<Todo> _finishedDailyTodos = [];
  List<Todo> get finishedDailyTodos => _finishedDailyTodos;

  List<Todo> _unfinishedTodos = [];
  List<Todo> get unfinishedTodos => _unfinishedTodos;

  List<Todo> _unfinishedPriorityTodos = [];
  List<Todo> get unfinishedPriorityTodos => _unfinishedPriorityTodos;

  List<Todo> _unfinishedNonPriorityTodos = [];
  List<Todo> get unfinishedNonPriorityTodos => _unfinishedNonPriorityTodos;

  Future<void> fetchTodos() async {
    _todos = await repository.fetchTodos();
    _finishedTodos = await repository.fetchFinishedTodos();
    _finishedDailyTodos = await repository.fetchFinishedDailyTodos();
    _unfinishedTodos = await repository.fetchUnfinishedTodos();
    _unfinishedPriorityTodos = await repository.fetchUnfinishedPriorityTodos();
    _unfinishedNonPriorityTodos =
        await repository.fetchUnfinishedNonPriorityTodos();
    notifyListeners();
  }

  void filterTasks(String searchText) async {
    _unfinishedPriorityTodos =
        await repository.filterUnfinishedPriorityTodos(searchText);
    _unfinishedNonPriorityTodos =
        await repository.filterUnfinishedNonPriorityTodos(searchText);
    notifyListeners();
  }

  Future<void> addTodo(Todo todo) async {
    if (!isStartDateBeforeEndDate(todo)) {
      throw Exception('Start date must be before end date');
    }
    await repository.addTodo(todo);
    fetchTodos();
  }

  Future<void> updateTodoStatus(int id, bool isCompleted) async {
    await repository.updateTodoStatus(id, isCompleted);
    fetchTodos();
  }

  Future<void> updateTodo(Todo todo) async {
    if (!isStartDateBeforeEndDate(todo)) {
      throw Exception('Start date must be before end date');
    }
    await repository.updateTodo(todo);
    fetchTodos();
  }

  Future<void> deleteTodo(Todo todo) async {
    await repository.deleteTodo(todo.id);
    fetchTodos();
  }

  Future<void> updateDailyTodoStatus() async {
    final dailyTodos = await repository.fetchFinishedDailyTodos();
    for (var todo in dailyTodos) {
      if (DateTime.now().isBefore(todo.endDate)) {
        await repository.updateTodoStatus(todo.id, false);
      }
    }
    fetchTodos();
  }

  bool isStartDateBeforeEndDate(Todo todo) {
    return todo.startDate.isBefore(todo.endDate);
  }
}
