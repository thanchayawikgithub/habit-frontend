import 'package:flutter/material.dart';

class BottomAppBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      items: [
        BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
        BottomNavigationBarItem(label: "Habit", icon: Icon(Icons.heart_broken)),
        BottomNavigationBarItem(
            label: "Profile", icon: Icon(Icons.account_circle))
      ],
    );
  }
}
