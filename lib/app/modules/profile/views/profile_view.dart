import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_frontend/app/layout/bottom_app_bar.dart';
import 'package:habit_frontend/app/modules/home/views/home_view.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({super.key});

  final TextEditingController nameController =
      TextEditingController(); // Controller for name field

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBarWidget(),
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.to(HomeView());
          },
        ),
      ),
      body: SingleChildScrollView(
        // ใช้ SingleChildScrollView เพื่อให้เนื้อหาเลื่อนได้
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20), // Spacing from AppBar
              Center(
                child: Column(
                  children: [
                    // Profile Picture
                    Obx(() {
                      // ตรวจสอบว่ามีการเลือกภาพหรือไม่
                      if (controller.selectedImagePath.value.isNotEmpty) {
                        // ตรวจสอบว่าไฟล์มีอยู่หรือไม่
                        if (File(controller.selectedImagePath.value)
                            .existsSync()) {
                          return CircleAvatar(
                            radius: 50,
                            backgroundImage: FileImage(
                              File(controller.selectedImagePath.value),
                            ),
                            // ทำให้ภาพพอดีกับขนาดของ CircleAvatar
                            backgroundColor: Colors.transparent,
                          );
                        } else {
                          // หากไฟล์ไม่พบหรือไม่มีอยู่ ให้แสดง Icon แทน
                          return const CircleAvatar(
                            radius: 50,
                            child: Icon(
                              Icons
                                  .person, // Default icon if no image selected or file not found
                              size: 50,
                            ),
                          );
                        }
                      } else {
                        // หากไม่มีการเลือกภาพ ให้แสดง Icon
                        return const CircleAvatar(
                          radius: 50,
                          child: Icon(
                            Icons.person, // Default icon if no image selected
                            size: 50,
                          ),
                        );
                      }
                    }),
                    const SizedBox(
                        height: 10), // Spacing between CircleAvatar and Text
                    // Change Picture Text under CircleAvatar
                    GestureDetector(
                      onTap: () {
                        controller.pickImage(); // Pick image action
                      },
                      child: const Text(
                        'Change Picture',
                        style: TextStyle(
                          color: Colors.blue, // Text color for clickable effect
                          decoration: TextDecoration
                              .underline, // Underline text for clickable appearance
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Display Name Label
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              // Name Field (Read-only)
              Obx(() {
                nameController.text = controller.displayName
                    .value; // Set the controller text from the observable
                return TextFormField(
                  controller:
                      nameController, // Use controller to edit/display the name
                  readOnly: true, // Set the field as read-only
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 30),
              // Save Button (if you want to keep it for other fields or remove if not needed)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.black, // Save button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // Save action (if needed for other fields)
                  },
                  child: const Text(
                    'SAVE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
