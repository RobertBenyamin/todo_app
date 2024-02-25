import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/model/todo.dart';
import 'package:todo_app/provider/todo_provider.dart';
import 'package:todo_app/widgets/custom_date_field.dart';
import 'package:todo_app/widgets/custom_text_field.dart';
import 'package:todo_app/widgets/custom_time_field.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  late TextEditingController _startDateController;
  late TextEditingController _startTimeController;
  late TextEditingController _endDateController;
  late TextEditingController _endTimeController;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  bool _isPriority = false;
  bool _isDaily = false;

  @override
  void initState() {
    super.initState();
    _startDateController = TextEditingController();
    _startTimeController = TextEditingController();
    _endDateController = TextEditingController();
    _endTimeController = TextEditingController();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  DateTime convertToDateTime(String formattedDate, String formattedTime) {
    DateFormat dateFormatter = DateFormat('dd MMM yyyy');
    DateFormat timeFormatter = DateFormat('hh:mm a');

    DateTime date = dateFormatter.parse(formattedDate);
    DateTime time = timeFormatter.parse(formattedTime);

    // Combine date and time
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(8),
            child: const Icon(Icons.arrow_back, color: Colors.deepPurple),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        CustomDateField(
                            textController: _startDateController,
                            isEnable: true,
                            title: "Start",
                            content: ""),
                        const SizedBox(height: 10),
                        CustomTimeField(
                          timeController: _startTimeController,
                          isEnable: true,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      children: [
                        CustomDateField(
                            textController: _endDateController,
                            isEnable: true,
                            title: "Ends",
                            content: ""),
                        const SizedBox(height: 10),
                        CustomTimeField(
                          timeController: _endTimeController,
                          isEnable: true,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CustomTextField(
                  textController: _titleController,
                  isEnable: true,
                  title: "Title",
                  content: ""),
              const SizedBox(height: 20),
              const Text(
                "Category",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isPriority = !_isPriority;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: _isPriority ? Colors.deepPurple : Colors.white,
                          border: Border.all(
                            color: _isPriority
                                ? Colors.deepPurple
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Priority Task',
                            style: TextStyle(
                              color: _isPriority
                                  ? Colors.white
                                  : Colors.deepPurple,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isDaily = !_isDaily;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: _isDaily ? Colors.deepPurple : Colors.white,
                          border: Border.all(
                            color: _isDaily
                                ? Colors.deepPurple
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Daily Task',
                            style: TextStyle(
                              color: _isDaily
                                  ? Colors.white
                                  : Colors.deepPurple,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Description",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                maxLines: 7,
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  DateTime startDate = convertToDateTime(
                      _startDateController.text, _startTimeController.text);
                  DateTime endDate = convertToDateTime(_endDateController.text,
                      _endTimeController.text);
                  String title = _titleController.text;
                  bool isPriority = _isPriority;
                  bool isDaily = _isDaily;
                  String description = _descriptionController.text;
                  bool isFinished = false;

                  Todo todo = Todo();
                  todo
                    ..startDate = startDate
                    ..endDate = endDate
                    ..title = title
                    ..isPriority = isPriority
                    ..isDaily = isDaily
                    ..description = description
                    ..isFinished = isFinished;
                  
                  context.read<TodoProvider>().addTodo(todo);
                  // Provider.of<TodoProvider>(context, listen: false).addTodo(todo);

                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepPurple,
                  ),
                  width: double.infinity,
                  child: const Center(
                    child: Text(
                      'Create Task',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _titleController.dispose();
    _endDateController.dispose();
    _endTimeController.dispose();
    _startTimeController.dispose();
    _startDateController.dispose();
    super.dispose();
  }
}
