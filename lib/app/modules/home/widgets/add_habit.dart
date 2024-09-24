import 'package:day_picker/day_picker.dart';
import 'package:flutter/material.dart';

class AddHabit extends StatelessWidget {
  AddHabit({Key? key}) : super(key: key);

  final List<DayInWeek> _days = [
    DayInWeek("Mon", dayKey: "monday"),
    DayInWeek("Thu", dayKey: "tuesday"),
    DayInWeek("Wed", dayKey: "wednesday"),
    DayInWeek("Thu", dayKey: "thursday"),
    DayInWeek("Fri", dayKey: "friday"),
    DayInWeek("Sat", dayKey: "saturday", isSelected: true),
    DayInWeek("Sun", dayKey: "sunday", isSelected: true),
  ];

  @override
  Widget build(BuildContext context) {
    final customWidgetKey = new GlobalKey<SelectWeekDaysState>();
    return FloatingActionButton(
        onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => Dialog.fullscreen(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Add Habit',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      Text("Title",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 20),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text("Description",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 20),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Text("Period",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(width: 5),
                          Text("(day)",
                              style: TextStyle(
                                fontSize: 14,
                              ))
                        ],
                      ),
                      SizedBox(height: 5),
                      TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 20),
                        ),
                      ),
                      SizedBox(height: 5),
                      SelectWeekDays(
                        key: customWidgetKey,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        unselectedDaysBorderColor: Colors.deepPurple[500],
                        unSelectedDayTextColor: Colors.deepPurple[500],
                        selectedDayTextColor: Colors.white,
                        selectedDaysFillColor: Colors.deepPurple[500],
                        selectedDaysBorderColor: Colors.deepPurple[500],
                        days: _days,
                        border: true,
                        borderWidth: 1,
                        width: MediaQuery.of(context).size.width,
                        boxDecoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        onSelect: (values) {
                          print(values);
                        },
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: MediaQuery.of(context).size.width, // Set width
                        height: 50, // Set height
                        child: ElevatedButton(
                          onPressed: () {
                            // Button action
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.deepPurple[500], // Background color
                            foregroundColor: Colors.white, // Text color
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(8), // Border radius
                            ),
                          ),
                          child: Text(
                            'Save',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width, // Set width
                        height: 50, // Set height
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // Button action
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.grey[100], // Background color
                            foregroundColor: Colors.black, // Text color
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(8), // Border radius
                            ),
                          ),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
        child: Icon(Icons.add),
        shape: CircleBorder());
  }
}
