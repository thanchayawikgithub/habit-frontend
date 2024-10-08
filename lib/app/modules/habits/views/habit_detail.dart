import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_frontend/app/data/models/habit.dart';
import 'package:habit_frontend/app/modules/habits/controllers/habits_controller.dart';

import 'package:habit_frontend/app/modules/habits/controllers/habits_detail_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class HabitDetailView extends GetView<HabitDetailController> {
  HabitsController habitsCtrl = Get.put(HabitsController());
  String? habitId = Get.parameters['id'];
  HabitDetailView({super.key}) {
    if (habitId != null) {
      habitsCtrl.fetchHabit(habitId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      Habit habit = habitsCtrl.habit.value;
      Map<DateTime, String> habitStatusMap = {};

      for (var record in habit.habitRecords) {
        DateTime recordDate =
            DateTime.parse(record.date); // Parsing string date
        DateTime today = DateTime.now();
        String status;

        // Compare only the date part (ignoring the time part).
        bool isToday = recordDate.year == today.year &&
            recordDate.month == today.month &&
            recordDate.day == today.day;

        switch (record.status) {
          case true:
            status = 'Complete';
            break;
          case false:
            if (isToday) {
              status = 'Pending'; // Status is 'Pending' for today's record.
            } else {
              status = 'Missing'; // Status is 'Missing' for past records.
            }
            break;
          default:
            status = 'Pending'; // Fallback for any other cases.
        }

        habitStatusMap[recordDate] = status;
      }

      return Scaffold(
        appBar: AppBar(
            backgroundColor: habit.color.withOpacity(50 / 255),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Get.back();
              },
            ),
            title: Row(
              children: [
                Icon(
                  habit.icon,
                  color: habit.color,
                  size: 30,
                ),
                SizedBox(width: 5),
                Text(habit.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ))
              ],
            )),
        body: Container(
          width: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Title',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  habit.title,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Description: ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  habit.description,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Reminder: ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  habit.reminderTime ?? 'off',
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TableCalendar(
                focusedDay: DateTime.now(),
                firstDay: DateTime(2010, 10, 16),
                lastDay: DateTime(2030, 3, 14),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, date, events) {
                    for (var recordDate in habitStatusMap.keys) {
                      if (recordDate.isSameDate(date)) {
                        String status = habitStatusMap[recordDate]!;
                        Color color;

                        switch (status) {
                          case 'Complete':
                            color = Colors.lightGreen;
                            break;
                          case 'Missing':
                            color = Colors.grey; // Use gray for "Missing"
                            break;
                          case 'Pending':
                            color = Colors.orange;
                            break;
                          default:
                            color = Colors
                                .grey; // Default color, in case of any other status
                        }

                        return Align(
                          alignment: Alignment.center,
                          child: Container(
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                            width: 30,
                            height: 30,
                            child: Center(
                              child: Text(
                                '${date.day}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      }
                    }

                    return null;
                  },
                ),
                onDaySelected: (selectedDay, focusedDay) {},
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Complete',
                  style: TextStyle(fontSize: 12),
                ),
                Padding(
                  padding: EdgeInsets.all(6),
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  'Missing',
                  style: TextStyle(fontSize: 12),
                ),
                Padding(
                  padding: EdgeInsets.all(6),
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  'Pending',
                  style: TextStyle(fontSize: 12),
                ),
                Padding(
                  padding: EdgeInsets.all(6),
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      );
    });
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime date) {
    return this.year == date.year &&
        this.month == date.month &&
        this.day == date.day;
  }
}
