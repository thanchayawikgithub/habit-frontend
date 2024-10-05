import 'package:get/get.dart';
import 'package:habit_frontend/app/modules/auth/controllers/auth_controller.dart';
import 'package:habit_frontend/app/modules/signup/controllers/signup_controller.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupController>(
      () => SignupController(),
    );
    Get.lazyPut<AuthController>(
      () => AuthController(),
    );
  }
}
