import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/habit_controller.dart';

class HabitView extends GetView<HabitController> {
  const HabitView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HabitView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'HabitView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
