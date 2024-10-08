import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:habit_frontend/app/layout/bottom_app_bar.dart';

import 'package:habit_frontend/app/modules/report/views/widget/report_list.dart';

import '../controllers/report_controller.dart';

class ReportView extends GetView<ReportController> {
  const ReportView(this.reportList, {super.key});
  final ReportList reportList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const BottomAppBarWidget(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Progress',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: false,
        ),
        body: const SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
        ));
  }
}
