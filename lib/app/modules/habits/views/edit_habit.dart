import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Models/configuration.dart';
import 'package:get/get.dart';
import 'package:habit_frontend/app/data/models/habit.dart';
import 'package:habit_frontend/app/modules/habits/controllers/habits_controller.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

class EditHabit extends StatelessWidget {
  final Habit? habit;
  final HabitsController controller = Get.put(HabitsController());

  EditHabit({super.key, this.habit}) {
    if (habit != null) {
      controller.setEditedHabit(habit!);
    } else {
      controller.clearForm();
    }
  }

  void pickIcon(BuildContext context) async {
    // Open the icon picker and get the selected icon
    IconPickerIcon? icon = await showIconPicker(
      context,
      configuration: SinglePickerConfiguration(
        iconPackModes: [IconPack.material],
      ),
    );
    if (icon != null) {
      controller.selectedIcon.value = icon.data;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back(); // กลับไปยังหน้าก่อนหน้า
            },
          ),
        ),
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                (habit != null) ? 'Edit Habit' : 'Add Habit',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text("Title",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              TextField(
                controller: controller.titleCtrl,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                ),
              ),
              const SizedBox(height: 16),
              const Text("Description",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              TextField(
                controller: controller.descriptionCtrl,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                ),
              ),
              const SizedBox(height: 10),
              const Text("Icon",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Row(
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      controller.selectedIcon.value,
                      size: 40,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        pickIcon(context);
                      },
                      child: Text('Pick Icon'))
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF6E33FF),
                      Color(0xFFB44AC3),
                      Color(0xFFCE62CF)
                    ], // สีตามในรูป
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.5),
                      offset: const Offset(0, 4),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (habit != null) {
                      controller.editHabit(habit!.id!);
                    } else {
                      controller.addHabit();
                    }
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.transparent, // ตั้งค่าพื้นหลังโปร่งใส
                    shadowColor: Colors.transparent, // ตั้งค่าเงาโปร่งใส
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
