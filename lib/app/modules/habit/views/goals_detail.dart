import 'package:flutter/material.dart';
import 'package:habit_frontend/app/modules/habit/views/habit_view.dart';

class GoalsDetail extends StatelessWidget {
  final HabitView habit;
  final int index;
  const GoalsDetail({super.key, required this.habit, required this.index});

  @override
  Widget build(BuildContext context) {
    final habits = habit.habitData[index];
    return Scaffold(
      appBar: AppBar(
        title: Text('Goals : ${habits.title}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Goals : ${habits.title}',
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: habits.status == 'Achieved'
                          ? Colors.green[100]
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      children: [
                        Text(
                          habits.status,
                          style: TextStyle(
                            color: habits.status == 'Achieved'
                                ? Colors.green
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Hbbit Name : ",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
