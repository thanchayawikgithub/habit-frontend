import 'package:flutter/material.dart';
import 'package:habit_frontend/app/modules/habit/views/Habit_Item.dart';
import 'package:habit_frontend/app/modules/habit/views/habit_view.dart';

class GoalsView extends StatefulWidget {
  const GoalsView({Key? key, required this.habit}) : super(key: key);
  final HabitView habit;
  @override
  _GoalsViewState createState() => _GoalsViewState();
}

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
        title: Text("Goals"),
        actions: [
          DropdownButton<String>(
            value: 'All', // The currently selected item
            icon: Icon(Icons.arrow_drop_down),
            underline: SizedBox(), // Remove the default underline
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
          SizedBox(
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
