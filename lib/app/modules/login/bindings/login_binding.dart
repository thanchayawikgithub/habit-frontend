import 'package:get/get.dart';
import 'package:habit_frontend/app/modules/auth/controllers/auth_controller.dart';
import 'package:habit_frontend/app/modules/login/controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.lazyPut<AuthController>(
      () => AuthController(),
    );
  }
}
