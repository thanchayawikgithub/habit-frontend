import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart'; // นำเข้า image_picker
import 'package:habit_frontend/app/layout/bottom_app_bar.dart';
import 'package:habit_frontend/app/modules/home/views/home_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firebase Firestore
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({super.key});

  final TextEditingController nameController =
      TextEditingController(); // Controller for name field
  final ImagePicker _picker = ImagePicker(); // สร้าง instance ของ ImagePicker
  RxString imagePath =
      ''.obs; // ตัวแปร observable เพื่อเก็บเส้นทางของรูปภาพที่เลือก

  // ฟังก์ชันเพื่อเลือกภาพจากแกลเลอรี่
  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath.value = image.path; // อัปเดตเส้นทางของภาพที่เลือก
    }
  }

  // ฟังก์ชัน Logout
  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut(); // ทำการ Sign out ผู้ใช้จาก Firebase
    Get.offAllNamed('/login'); // เปลี่ยนไปยังหน้า Login
  }

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
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _logout(); // เรียกฟังก์ชัน Logout เมื่อกดปุ่ม
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20), // Spacing from AppBar

              // Profile Picture Section
              Obx(() {
                return GestureDetector(
                  onTap: _pickImage, // คลิกเพื่อเลือกภาพจากแกลเลอรี่
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: imagePath.value.isNotEmpty
                        ? FileImage(File(imagePath.value))
                        : null, // ถ้าไม่มีภาพจะใช้ค่า null
                    child: imagePath.value.isEmpty
                        ? const Icon(Icons.person, size: 50) // ใช้ icon แทน
                        : null, // ถ้ามีภาพแล้วจะไม่แสดง icon
                  ),
                );
              }),
              const SizedBox(height: 10),

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

              // Name Field (Read-only) with Edit Button
              Obx(() {
                nameController.text = controller.displayName
                    .value; // Set the controller text from the observable
                return Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    TextFormField(
                      controller:
                          nameController, // Use controller to edit/display the name
                      readOnly: true, // Set the field as read-only
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // เปลี่ยน TextFormField ให้เป็น editable mode
                        nameController.text = controller.displayName.value;
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Edit Name"),
                              content: TextFormField(
                                controller: nameController,
                                decoration: const InputDecoration(
                                  labelText: "Enter your name",
                                ),
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () async {
                                    String newName = nameController.text;
                                    await controller.updateDisplayName(
                                        newName); // อัปเดตชื่อใน Firebase
                                    Get.back(); // ปิด dialog
                                  },
                                  child: const Text("Save"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Get.back(); // ปิด dialog โดยไม่บันทึก
                                  },
                                  child: const Text("Cancel"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                );
              }),

              const SizedBox(height: 30),

              // Save Button with Gradient
              SizedBox(
                width: double
                    .infinity, // ทำให้ปุ่มมีความกว้างเต็มตามขนาดของ parent
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    backgroundColor: Colors
                        .transparent, // ลบ padding เดิมของปุ่มเพื่อให้จัดการความสูงใน Container แทน
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ), // ทำให้ปุ่มเป็นโปร่งใส เพื่อใช้ gradient
                    shadowColor: Colors.transparent, // ลบเงาเดิมของปุ่มออก
                  ),
                  onPressed: () {
                    // Save action (if needed for other fields)
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF6E33FF),
                          Color(0xFFB44AC3),
                          Color(0xFFCE62CF)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      height: 50, // กำหนดความสูงให้กับปุ่ม
                      alignment: Alignment.center,
                      child: const Text(
                        'SAVE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
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
