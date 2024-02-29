import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/model/todo.dart';
import 'package:todo_app/provider/todo_provider.dart';
import 'package:todo_app/utils/date_time_helper.dart';
import 'package:todo_app/widgets/custom_date_field.dart';
import 'package:todo_app/widgets/custom_text_field.dart';
import 'package:todo_app/widgets/custom_time_field.dart';

class EditTodoPage extends StatefulWidget {
  final Todo todo;

  const EditTodoPage({super.key, required this.todo});

  @override
  State<EditTodoPage> createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
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

    _startDateController.text =
        DateTimeHelper.formatDate(widget.todo.startDate);
    _startTimeController.text =
        DateTimeHelper.formatTime(widget.todo.startDate);
    _endDateController.text = DateTimeHelper.formatDate(widget.todo.endDate);
    _endTimeController.text = DateTimeHelper.formatTime(widget.todo.endDate);
    _titleController.text = widget.todo.title;
    _descriptionController.text = widget.todo.description ?? "";
    _isPriority = widget.todo.isPriority;
    _isDaily = widget.todo.isDaily;
  }

  bool _areFieldsNotEmpty() {
    return _startDateController.text.isNotEmpty &&
        _startTimeController.text.isNotEmpty &&
        _endDateController.text.isNotEmpty &&
        _endTimeController.text.isNotEmpty &&
        _titleController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Task',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF5038BC),
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
            child: const Icon(Icons.arrow_back, color: Color(0xFF5038BC)),
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
                            isRequired: true,
                            content: DateTimeHelper.formatDate(
                                widget.todo.startDate)),
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
                            content:
                                DateTimeHelper.formatDate(widget.todo.endDate)),
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
                isRequired: true,
              ),
              const SizedBox(height: 20),
              const Text(
                "Category",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5038BC),
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
                          color: _isPriority
                              ? const Color(0xFF5038BC)
                              : Colors.white,
                          border: Border.all(
                            color: _isPriority
                                ? const Color(0xFF5038BC)
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Priority Task',
                            style: TextStyle(
                              color: _isPriority
                                  ? Colors.white
                                  : const Color(0xFF5038BC),
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
                          color:
                              _isDaily ? const Color(0xFF5038BC) : Colors.white,
                          border: Border.all(
                            color: _isDaily
                                ? const Color(0xFF5038BC)
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Daily Task',
                            style: TextStyle(
                              color: _isDaily
                                  ? Colors.white
                                  : const Color(0xFF5038BC),
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
                  color: Color(0xFF5038BC),
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
                  if (!_areFieldsNotEmpty()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill in all required fields.'),
                      ),
                    );
                    return;
                  }

                  DateTime startDate = DateTimeHelper.convertToDateTime(
                      _startDateController.text, _startTimeController.text);
                  DateTime endDate = DateTimeHelper.convertToDateTime(
                      _endDateController.text, _endTimeController.text);
                  String title = _titleController.text;
                  bool isPriority = _isPriority;
                  bool isDaily = _isDaily;
                  String description = _descriptionController.text;
                  bool isFinished = widget.todo.isFinished;

                  widget.todo
                    ..startDate = startDate
                    ..endDate = endDate
                    ..title = title
                    ..isPriority = isPriority
                    ..isDaily = isDaily
                    ..description = description
                    ..isFinished = isFinished;

                  context
                      .read<TodoProvider>()
                      .updateTodo(widget.todo)
                      .then((value) => {Navigator.pop(context)})
                      .catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(error.message),
                      ),
                    );
                    throw error;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFF5038BC),
                  ),
                  width: double.infinity,
                  child: const Center(
                    child: Text(
                      'Edit Task',
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
