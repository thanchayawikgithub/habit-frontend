import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:habit_frontend/app/layout/bottom_app_bar.dart';
import 'package:habit_frontend/app/modules/home/views/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ฟังก์ชัน Logout
  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    // โหลดรูปโปรไฟล์จาก Firebase เมื่อหน้าเพจนี้ถูกสร้างขึ้น
    // _loadProfileImage();

    return Scaffold(
      bottomNavigationBar: const BottomAppBarWidget(),
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
              _logout();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // Profile Picture Section

            GestureDetector(
              onTap: controller.pickAndUploadImage,
              child: CircleAvatar(
                radius: 70,
                backgroundImage: _auth.currentUser?.photoURL != null
                    ? NetworkImage(_auth.currentUser!.photoURL!)
                    : null, // แสดงรูปจาก URL
                child: _auth.currentUser?.photoURL == null
                    ? const Icon(Icons.person, size: 50)
                    : null,
              ),
            ),

            const SizedBox(height: 10),

            Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _auth.currentUser?.displayName ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Edit Name"),
                          content: TextFormField(
                            controller: controller.displayNameCtrl,
                            decoration: const InputDecoration(
                              labelText: "Enter your name",
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () async {
                                await controller.updateDisplayName();
                                Get.back();
                              },
                              child: const Text("Save"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.back();
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
            ))
          ],
        ),
      ),
    );
  }
}
