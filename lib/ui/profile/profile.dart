import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/profile/edit_profile.dart';
import 'package:todo_app/provider/profile_provider.dart';
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
  String _profilePicture = '';

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
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: const Text('My Profile'),
        centerTitle: true,
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
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  textController: _nameController,
                  isEnable: false,
                  title: "Name",
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  textController: _majorController,
                  isEnable: false,
                  title: "Major",
                ),
                const SizedBox(height: 20),
                CustomDateField(
                    textController: _dateController,
                    isEnable: false,
                    title: "Date of Birth",
                    content: provider.dateOfBirth),
                const SizedBox(height: 20),
                CustomTextField(
                  textController: _emailController,
                  isEnable: false,
                  title: "Email",
                ),
              ],
            ),
          ),
        );
      }),
      // Dummy Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Edit Profile",
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 400),
              pageBuilder: (context, animation, secondaryAnimation) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).animate(animation),
                  child: ChangeNotifierProvider.value(
                    value: context.read<ProfileProvider>(),
                    child: const EditProfilePage(),
                  ),
                );
              },
            ),
          );
        },
        child: const Icon(Icons.edit),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
