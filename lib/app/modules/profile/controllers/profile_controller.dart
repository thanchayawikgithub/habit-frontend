import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileController extends GetxController {
  var selectedImagePath = ''.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var displayName = ''.obs; // Observable variable to store the display name
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        selectedImagePath.value = pickedFile.path; // Update image path
      } else {
        Get.snackbar('Error', 'No image selected');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }

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
      await currentUser
          .updateDisplayName(newName); // Update displayName in Firebase
      displayName.value = newName; // Update the displayName in the controller
    }
  }
}
