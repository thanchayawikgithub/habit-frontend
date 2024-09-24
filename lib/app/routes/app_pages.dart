import 'package:get/get.dart';
import 'package:habit_frontend/app/modules/report/report.dart';
import 'package:habit_frontend/app/modules/report/views/goals_detail.dart';
import 'package:habit_frontend/app/modules/report/views/goals_view.dart';
import 'package:habit_frontend/app/modules/report/views/widget/report_list.dart';
import 'package:habit_frontend/app/modules/report/views/widget/report_widget.dart';
import 'package:habit_frontend/app/modules/login/bindings/login_binding.dart';
import 'package:habit_frontend/app/modules/login/views/login_view.dart';
import 'package:habit_frontend/app/modules/signup/bindings/signup_binding.dart';
import 'package:habit_frontend/app/modules/signup/views/signup_view.dart';

import '../modules/report/bindings/report_binding.dart';
import '../modules/report/views/report_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;
  static late ReportList reportList;
  static late Report reports;
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
      name: _Paths.PROGRESS,
      page: () => ReportView(ReportList()),
      binding: ReportBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.GOALS,
      page: () => GoalsView(
        report: ReportList(),
      ),
      binding: ReportBinding(),
    ),
    //goals_detail
    // GetPage(
    //   name: _Paths.GOALSDETAIL,
    //   page: () => GoalsDetail(
    //     habit: HabitView(), index: ,
    //   ),
    //   binding: HabitBinding(),
    // ),
  ];
}
