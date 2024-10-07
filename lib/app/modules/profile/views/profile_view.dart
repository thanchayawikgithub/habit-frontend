import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:habit_frontend/app/layout/bottom_app_bar.dart';
import 'package:habit_frontend/app/modules/home/views/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart'; // Firebase Storage
import 'package:cloud_firestore/cloud_firestore.dart'; // Firebase Firestore
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({super.key});

  final TextEditingController nameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  RxString imagePath = ''.obs;
  RxString imageUrl = ''.obs; // URL ของรูปภาพที่จะดึงจาก Firebase

  // ฟังก์ชันเพื่อเลือกภาพจากแกลเลอรี่และอัปโหลดไปยัง Firebase
  Future<void> _pickAndUploadImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath.value = image.path; // อัปเดตเส้นทางของภาพที่เลือก

      // อัปโหลดรูปไปยัง Firebase Storage
      File file = File(image.path);
      try {
        String uid = FirebaseAuth.instance.currentUser!.uid;
        String fileName = 'profile_pictures/$uid/profile.jpg';

        // อัปโหลดรูปไปที่ path ใน Firebase Storage
        TaskSnapshot snapshot =
            await FirebaseStorage.instance.ref(fileName).putFile(file);

        // ดึง URL ของรูปที่อัปโหลดมาเก็บไว้ใน Firestore
        String downloadUrl = await snapshot.ref.getDownloadURL();
        imageUrl.value = downloadUrl; // อัปเดต URL ของรูปภาพ

        // อัปเดตข้อมูล URL ใน Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .update({'profileImageUrl': downloadUrl});

        Get.snackbar('Success', 'Profile picture updated successfully!');
      } catch (e) {
        Get.snackbar('Error', 'Failed to upload image: $e');
      }
    }
  }

  // ฟังก์ชัน Logout
  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed('/login');
  }

  // ฟังก์ชันสำหรับดึงรูปภาพจาก Firestore (ตอนเปิดหน้าครั้งแรก)
  Future<void> _loadProfileImage() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (userDoc.exists && userDoc['profileImageUrl'] != null) {
      imageUrl.value = userDoc['profileImageUrl'];
    }
  }

  @override
  Widget build(BuildContext context) {
    // โหลดรูปโปรไฟล์จาก Firebase เมื่อหน้าเพจนี้ถูกสร้างขึ้น
    _loadProfileImage();

    return Scaffold(
      bottomNavigationBar: const BottomAppBarWidget(),
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
              _logout();
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
              const SizedBox(height: 20),

              // Profile Picture Section
              Obx(() {
                return GestureDetector(
                  onTap: _pickAndUploadImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: imageUrl.value.isNotEmpty
                        ? NetworkImage(imageUrl.value)
                        : null, // แสดงรูปจาก URL
                    child: imageUrl.value.isEmpty
                        ? const Icon(Icons.person, size: 50)
                        : null,
                  ),
                );
              }),
              const SizedBox(height: 10),

              // Edit Profile Picture Button
              ElevatedButton.icon(
                onPressed: _pickAndUploadImage,
                icon: const Icon(Icons.edit),
                label: const Text("Edit Profile Picture"),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
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

              // Name Field (Read-only) with Edit Button
              Obx(() {
                nameController.text = controller.displayName.value;
                return Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    TextFormField(
                      controller: nameController,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
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
                                    await controller.updateDisplayName(newName);
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
                );
              }),

              const SizedBox(height: 30),

              // Save Button with Gradient
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: () {},
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
                      height: 50,
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
