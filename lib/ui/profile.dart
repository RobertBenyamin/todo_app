import 'package:flutter/material.dart';
import 'package:todo_app/widgets/custom_date_field.dart';
import 'package:todo_app/widgets/custom_text_field.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _majorController;
  late TextEditingController _dateController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _majorController = TextEditingController();
    _dateController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: const Center(child: Text('My Profile')),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 24),
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(64),
            topRight: Radius.circular(64),
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      const AssetImage('assets/images/profile_picture.png'),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: Colors.deepPurple, width: 2),
                          color: Colors.white,
                        ),
                        child: const Icon(Icons.edit, color: Colors.deepPurple),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                textController: _nameController,
                isEnable: false,
                title: "Name",
                content: "Ristek",
              ),
              const SizedBox(height: 20),
              CustomTextField(
                textController: _majorController,
                isEnable: false,
                title: "Major",
                content: "Ilmu Komputer",
              ),
              const SizedBox(height: 20),
              CustomDateField(
                  textController: _dateController,
                  isEnable: false,
                  title: "Date of Birth",
                  content: "13 Jun 2004"),
              const SizedBox(height: 20),
              CustomTextField(
                textController: _emailController,
                isEnable: false,
                title: "Email",
                content: "carlenee@ristek.ui.ac.id",
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _dateController.dispose();
    _majorController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
