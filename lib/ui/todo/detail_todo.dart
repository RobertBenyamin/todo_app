import 'package:flutter/material.dart';
import 'package:todo_app/data/model/todo.dart';
import 'package:todo_app/utils/date_time_helper.dart';
import 'package:todo_app/widgets/custom_date_field.dart';
import 'package:todo_app/widgets/custom_time_field.dart';

class DetailTodoPage extends StatefulWidget {
  final Todo todo;

  const DetailTodoPage({super.key, required this.todo});

  @override
  State<DetailTodoPage> createState() => _DetailTodoPageState();
}

class _DetailTodoPageState extends State<DetailTodoPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Task'),
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
              Center(
                child: Text(
                  widget.todo.title.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        CustomDateField(
                            textController: _startDateController,
                            isEnable: false,
                            title: "Start",
                            content: DateTimeHelper.formatDate(
                                widget.todo.startDate)),
                        const SizedBox(height: 10),
                        CustomTimeField(
                          timeController: _startTimeController,
                          isEnable: false,
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
                            isEnable: false,
                            title: "Ends",
                            content:
                                DateTimeHelper.formatDate(widget.todo.endDate)),
                        const SizedBox(height: 10),
                        CustomTimeField(
                          timeController: _endTimeController,
                          isEnable: false,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (_isDaily || _isPriority)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                        if (_isPriority)
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: _isPriority
                                    ? Colors.deepPurple
                                    : Colors.white,
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
                        if (_isDaily && _isPriority) const SizedBox(width: 16),
                        if (_isDaily)
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:
                                    _isDaily ? Colors.deepPurple : Colors.white,
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
                      ],
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
                enabled: false,
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
