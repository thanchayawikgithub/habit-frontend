import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomAppBarWidget extends StatefulWidget {
  const BottomAppBarWidget({super.key});

  @override
  _BottomAppBarWidgetState createState() => _BottomAppBarWidgetState();
}

class _BottomAppBarWidgetState extends State<BottomAppBarWidget> {
  int _currentIndex = 0;
  final List<String> paths = ["/home", "/habits", "/profile"];

  @override
  void initState() {
    super.initState();

    // Set _currentIndex based on current route
    final currentRoute = Get.currentRoute;
    if (paths.contains(currentRoute)) {
      _currentIndex = paths.indexOf(currentRoute);
    }
  }

  void _onItemTapped(int index) {
    // Navigate to the selected path
    Get.toNamed(paths[index]);
    setState(() {
      _currentIndex = index;
    });
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
        BottomNavigationBarItem(
          label: "Habits",
          icon: Icon(Icons.favorite),
        ),
        BottomNavigationBarItem(
          label: "Profile",
          icon: Icon(Icons.account_circle),
        ),
      ],
    );
  }
}
