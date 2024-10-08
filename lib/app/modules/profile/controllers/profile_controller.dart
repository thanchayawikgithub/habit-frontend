import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController displayNameCtrl = TextEditingController();
  RxString imagePath = ''.obs;
  final ImagePicker _picker = ImagePicker();
  // RxString imageUrl = ''.obs; // URL ของรูปภาพที่จะดึงจาก Firebase
  // @override
  // void onInit() {
  //   super.onInit();
  //   // Load the current user's displayName
  //   final User? currentUser = _auth.currentUser;
  //   if (currentUser != null) {
  //     displayName.value = currentUser.displayName ??
  //         ''; // Set displayName to the observable variable
  //   }
  // }

  Future<void> pickAndUploadImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      try {
        // Get the file extension (e.g., jpg, png)
        String fileExtension = image.path.split('.').last;

        // Get the current user's ID
        String userId = _auth.currentUser!.uid;

        // Define the file path in Firebase Storage (profileImage/userId.[fileExtension])
        String filePath = 'profileImage/$userId.$fileExtension';

        print(filePath);
        // Upload the image to Firebase Storage
        TaskSnapshot snapshot = await FirebaseStorage.instance
            .ref(filePath)
            .putFile(File(image.path));

        // Get the download URL of the uploaded image
        String downloadUrl = await snapshot.ref.getDownloadURL();

        // Update the user's profile with the new image URL
        await _auth.currentUser!.updatePhotoURL(downloadUrl);

        // Show a success message
        Get.snackbar('Success', 'Profile picture updated successfully!');
      } catch (e) {
        print(e);
        // Handle upload error
        Get.snackbar('Error', 'Failed to upload image: $e');
      }
    }
  }

  // Function to update the display name in Firebase
  Future<void> updateDisplayName() async {
    final User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      await currentUser.updateDisplayName(
          displayNameCtrl.text); // Update displayName in Firebase
    }
  }
}
