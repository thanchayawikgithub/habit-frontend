import 'package:get/get.dart';
import 'package:habit_frontend/app/modules/habits/controllers/habits_detail_controller.dart';

class HabitDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HabitDetailController>(() => HabitDetailController());
  }
}
