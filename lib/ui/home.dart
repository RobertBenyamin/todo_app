import 'package:flutter/material.dart';
import 'package:todo_app/ui/todo/todo_list.dart';
import 'package:todo_app/ui/profile/profile.dart';
import 'package:todo_app/ui/todo/finished_todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  final screens = <Widget>[
    const TodoPage(),
    const FinishedTodoPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: screens[index],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (int index) {
            setState(() {
              this.index = index;
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 32),
              label: 'Todo',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.check_circle, size: 32),
              label: 'Finished',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 32),
              label: 'Profile',
            ),
          ],
        ));
  }
}
