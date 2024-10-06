import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firebase Firestore

class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var displayName = ''.obs; // Observable variable to store the display name

  @override
  void onInit() {
    super.onInit();
    // Load the current user's displayName
    final User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      displayName.value = currentUser.displayName ??
          ''; // Set displayName to the observable variable
    }
  }

  // Function to update the display name in Firebase
  Future<void> updateDisplayName(String newName) async {
    final User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      try {
        // Update displayName in Firebase Auth
        await currentUser.updateDisplayName(newName);

        // Update displayName in Firestore (if you store user data there)
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .update({'name': newName});

        // Update the displayName in the controller
        displayName.value = newName;
      } catch (e) {
        print('Error updating name: $e');
      }
    }
  }
}
