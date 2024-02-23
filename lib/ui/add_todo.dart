import 'package:flutter/material.dart';
import 'package:todo_app/widgets/custom_date_field.dart';
import 'package:todo_app/widgets/custom_text_field.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  bool _isPriority = true;

  @override
  void initState() {
    super.initState();
    _startDateController = TextEditingController();
    _endDateController = TextEditingController();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
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
                    child: CustomDateField(
                        textController: _startDateController,
                        isEnable: true,
                        title: "Start",
                        content: ""),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomDateField(
                        textController: _endDateController,
                        isEnable: true,
                        title: "Ends",
                        content: ""),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CustomTextField(
                  textController: _titleController,
                  isEnable: true,
                  title: "Title",
                  content: "Mobile Development"),
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
                          _isPriority = true;
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
                          _isPriority = false;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: _isPriority ? Colors.white : Colors.deepPurple,
                          border: Border.all(
                            color: _isPriority
                                ? Colors.grey.shade300
                                : Colors.deepPurple,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Daily Task',
                            style: TextStyle(
                              color: _isPriority
                                  ? Colors.deepPurple
                                  : Colors.white,
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
                onTap: () {},
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
    _startDateController.dispose();
    super.dispose();
  }
}
