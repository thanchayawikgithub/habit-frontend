import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomAppBarWidget extends StatefulWidget {
  const BottomAppBarWidget({super.key});

  @override
  _BottomAppBarWidgetState createState() => _BottomAppBarWidgetState();
}

class _BottomAppBarWidgetState extends State<BottomAppBarWidget> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Get.toNamed('/home');
        break;
      case 1:
        Get.toNamed('/habits');
        break;
      case 2:
        Get.toNamed('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.purple,
      unselectedItemColor: Colors.grey,
      currentIndex: _currentIndex,
      onTap: _onItemTapped,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      items: const [
        BottomNavigationBarItem(
          label: "Home",
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(label: "Habit", icon: Icon(Icons.heart_broken)),
        BottomNavigationBarItem(
            label: "Profile", icon: Icon(Icons.account_circle)),
      ],
    );
  }
}
