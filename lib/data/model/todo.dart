import 'package:isar/isar.dart';

part 'todo.g.dart';

@Collection()
class Todo {
  Id id = Isar.autoIncrement;

  @Index()
  late DateTime startDate;

  @Index()
  late DateTime endDate;

  @Index()
  late String title;

  bool isPriority = false;

  bool isDaily = false;

  String? description;

  bool isFinished = false;
}
