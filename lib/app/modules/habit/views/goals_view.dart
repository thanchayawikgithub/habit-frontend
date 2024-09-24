import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:habit_frontend/app/modules/habit/views/Habit_Item.dart';
import 'package:habit_frontend/app/modules/habit/views/goals_detail.dart';
import 'package:habit_frontend/app/modules/habit/views/habit_view.dart';

class GoalsView extends StatefulWidget {
  const GoalsView({super.key, required this.habit});
  final HabitView habit;
  @override
  _GoalsViewState createState() => _GoalsViewState();
}

// void indexHabit(int index, HabitItem habit) {
//   habit.habitData[index] = habit;
// }

class _GoalsViewState extends State<GoalsView> {
  String? selectedValue; // Variable to store the selected dropdown value
  List<String> dropdownItems = [
    "All",
    "Option 2",
    "Option 3"
  ]; // Dropdown options

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Goals"),
        actions: [
          DropdownButton<String>(
            value: 'All', // The currently selected item
            icon: const Icon(Icons.arrow_drop_down),
            underline: const SizedBox(), // Remove the default underline
            items: dropdownItems.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedValue = newValue; // Update the selected value
              });
            },
          ),
          const SizedBox(
              width: 16), // Add some space to the right of the DropdownButton
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.builder(
          itemCount: widget.habit.habitData.length,
          itemBuilder: (context, index) {
            final habits = widget.habit.habitData[index];
            return InkWell(
              onTap: () {
                // Action to perform when an item is tapped
                print("Tapped on index: $index");
                // You can navigate to a detailed view or perform another action here
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => GoalsDetail(
                //             habit: HabitView(),
                //           )),
                // );
                Get.to(() => GoalsDetail(
                      habit: widget.habit, // ส่งข้อมูล habit ทั้งหมด
                      index: index,
                    ));
              },
              child: HabitItem(
                title: habits.title,
                progress: habits.progress,
                target: habits.target,
                status: habits.status,
                id: habits.id,
              ),
            );
          },
        ),
      ),
    );
  }
}
