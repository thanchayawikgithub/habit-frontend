import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:habit_frontend/app/layout/bottom_app_bar.dart';

import 'package:habit_frontend/app/modules/report/report.dart';
import 'package:habit_frontend/app/modules/report/views/widget/report_list.dart';
import 'package:habit_frontend/app/modules/report/views/widget/report_widget.dart';

import '../controllers/report_controller.dart';

class ReportView extends GetView<ReportController> {
  ReportView(this.reportList, {super.key});
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
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and Dropdown
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Progress Report',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownButton<String>(
                    value: 'This Month',
                    elevation: 40,
                    onChanged: (String? newValue) {},
                    items: <String>['This Month', 'Last Month']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                ],
              ),
              const SizedBox(height: 20),
              // Progress Circle and Goals Summary
              Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Goals list
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Your Goals',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.toNamed('/goals');
                                  },
                                  child: const Text(
                                    'See All',
                                    style: TextStyle(color: Colors.purple),
                                  ),
                                ),
                              ],
                            ),
                            // Progress circle
                            Center(
                                child: Column(children: [
                              SizedBox(
                                  width: 150,
                                  height: 150,
                                  child: Stack(fit: StackFit.expand, children: [
                                    CircularProgressIndicator(
                                      value: 0.6,
                                      strokeWidth: 10,
                                      backgroundColor: Colors.grey[300],
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                              Colors.purple),
                                    ),
                                    const SizedBox(height: 20),
                                    const Center(
                                      child: Text(
                                        '60%',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.purple,
                                        ),
                                      ),
                                    ),
                                  ])),
                              const SizedBox(height: 15),
                              RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '✔ 11 Reports goal has achieved\n',
                                      style: TextStyle(color: Colors.purple),
                                    ),
                                    TextSpan(
                                      text: '✘ 6 Reports goal hasn\'t achieved',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ])),
                            const SizedBox(height: 20),
                            // ListView of Report Items
                            SizedBox(
                              height: 300,
                              child: ListView.builder(
                                itemCount: reportList.reportData.length,
                                itemBuilder: (context, index) {
                                  final reports = reportList.reportData[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: ReportWidget(
                                      report:
                                          reports, // Pass the individual Report object
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  // ใส่ฟังก์ชันที่ต้องการทำงานเมื่อกดปุ่ม
                                  Get.toNamed('/goals');
                                },
                                child: const Text(
                                  'See All',
                                  style: TextStyle(color: Colors.purple),
                                ),
                              ),
                            ),
                          ])))
            ],
          ),
        ));
  }
}
