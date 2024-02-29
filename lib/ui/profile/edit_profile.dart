import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
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
  String _profilePicture = '';
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _majorController = TextEditingController();
    _dateController = TextEditingController();
    _emailController = TextEditingController();
  }

  Future<void> _getImage(ImageSource source, BuildContext context) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      _profilePicture = pickedFile.path;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
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
      body: Consumer<ProfileProvider>(builder: (context, provider, _) {
        _nameController.text = provider.name;
        _majorController.text = provider.major;
        _dateController.text = provider.dateOfBirth;
        _emailController.text = provider.email;
        _profilePicture = provider.profilePicture;

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
                    backgroundImage: _profilePicture.isEmpty
                        ? const AssetImage('assets/images/profile_picture.png')
                        : Image.file(File(_profilePicture)).image,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Choose Image Source'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                        leading: const Icon(Icons.camera_alt),
                                        title: const Text('Camera'),
                                        onTap: () {
                                          _getImage(
                                              ImageSource.camera, context);
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading:
                                            const Icon(Icons.photo_library),
                                        title: const Text('Gallery'),
                                        onTap: () {
                                          _getImage(
                                              ImageSource.gallery, context);
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: const Color(0xFF5038BC), width: 2),
                            color: Colors.white,
                          ),
                          child:
                              const Icon(Icons.edit, color: Color(0xFF5038BC)),
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
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  textController: _majorController,
                  isEnable: true,
                  title: "Major",
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
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    context.read<ProfileProvider>().updateProfile(
                          _nameController.text,
                          _majorController.text,
                          _dateController.text,
                          _emailController.text,
                          _profilePicture,
                        );
                    Navigator.pop(context);
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
