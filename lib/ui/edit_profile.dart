import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/profile_provider.dart';
import 'package:todo_app/widgets/custom_date_field.dart';
import 'package:todo_app/widgets/custom_text_field.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
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
      appBar: AppBar(
        title: const Text('Edit Profile'),
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
      body: Consumer<ProfileProvider>(builder: (context, provider, _) {
        return SingleChildScrollView(
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
                          child:
                              const Icon(Icons.edit, color: Colors.deepPurple),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  textController: _nameController,
                  isEnable: true,
                  title: "Name",
                  content: provider.name,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  textController: _majorController,
                  isEnable: true,
                  title: "Major",
                  content: provider.major,
                ),
                const SizedBox(height: 20),
                CustomDateField(
                    textController: _dateController,
                    isEnable: true,
                    title: "Date of Birth",
                    content: provider.dateOfBirth),
                const SizedBox(height: 20),
                CustomTextField(
                  textController: _emailController,
                  isEnable: true,
                  title: "Email",
                  content: provider.email,
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    context.read<ProfileProvider>().updateProfile(
                          _nameController.text,
                          _majorController.text,
                          _dateController.text,
                          _emailController.text,
                        );
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
                        'Edit Profile',
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
        );
      }),
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
