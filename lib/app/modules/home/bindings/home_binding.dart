import 'package:get/get.dart';
import 'package:habit_frontend/app/modules/auth/controllers/auth_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<AuthController>(
      () => AuthController(),
    );
  }
}
