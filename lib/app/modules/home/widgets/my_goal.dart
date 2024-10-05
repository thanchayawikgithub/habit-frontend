import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_frontend/app/modules/home/controllers/home_controller.dart';

class MyGoals extends GetView<HomeController> {
  const MyGoals({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Card(
        color: Colors.white,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 450,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'My Goals',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  TextButton(
                      onPressed: () {
                        Get.toNamed('/my_goals_detail/');
                      },
                      child: Text(
                        'See all',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.deepOrange[500]),
                      ))
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.habitsList.length,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: const EdgeInsets.only(
                            bottom: 8), // Space between items
                        decoration: BoxDecoration(
                          color: Colors.grey[100], // Grey background
                          borderRadius:
                              BorderRadius.circular(12), // Rounded corners
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    controller.habitsList[index].title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  const Icon(Icons.more_vert)
                                ],
                              ),
                              const SizedBox(height: 8),
                              LinearProgressIndicator(
                                value: 0.5,
                                backgroundColor: Colors.grey[300],
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Colors.deepPurple),
                                minHeight: 10,
                                borderRadius: BorderRadius.circular(4),
                                // Adjust thickness as needed
                              ),
                              const SizedBox(height: 8),
                              const Text("5 fron 7 day target"),
                              Text(
                                "Everyday",
                                style: TextStyle(color: Colors.deepOrange[500]),
                              ),
                            ],
                          ),
                        ));
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
