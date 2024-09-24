import 'package:get/get.dart';
import 'package:habit_frontend/app/modules/habit/views/goals_view.dart';
import 'package:habit_frontend/app/modules/login/bindings/login_binding.dart';
import 'package:habit_frontend/app/modules/login/views/login_view.dart';
import 'package:habit_frontend/app/modules/signup/bindings/signup_binding.dart';
import 'package:habit_frontend/app/modules/signup/views/signup_view.dart';

import '../modules/habit/bindings/habit_binding.dart';
import '../modules/habit/views/habit_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.HABIT,
      page: () => HabitView(),
      binding: HabitBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.GOALS,
      page: () => GoalsView(habit: HabitView()),
      binding: HabitBinding(),
    ),
    // GetPage(
    //   name: _Paths.GOALS,
    //   page: () => GoalsDetail(
    //      ,
    //   ),
    //   binding: HabitBinding(),
    // ),
  ];
}
