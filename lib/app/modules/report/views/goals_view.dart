import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_frontend/app/modules/report/views/widget/report_list.dart';
import 'package:habit_frontend/app/modules/report/views/widget/report_widget.dart';

class GoalsView extends StatefulWidget {
  const GoalsView({super.key, required this.report});
  final ReportList report;
  @override
  _GoalsViewState createState() => _GoalsViewState();
}

// void indexReport(int index, ReportItem report) {
//   report.reportData[index] = report;
// }

class _GoalsViewState extends State<GoalsView> {
  String? selectedValue; // Variable to store the selected dropdown value
  List<String> dropdownItems = [
    "All",
  ]; // Dropdown options

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Goals"),
        actions: [
          DropdownButton<String>(
            value: 'All', // The currently selected item
            icon: const Icon(Icons.arrow_drop_down),
            underline: const SizedBox(), // Remove the default underline
            items: dropdownItems.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedValue = newValue; // Update the selected value
              });
            },
          ),
          const SizedBox(
              width: 16), // Add some space to the right of the DropdownButton
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.builder(
          itemCount: widget.report.reportData.length,
          itemBuilder: (context, index) {
            final reports = widget.report.reportData[index];
            return InkWell(
                onTap: () {
                  // Action to perform when an item is tapped
                  print("Tapped on index: $index");
                  // Get.to(
                  //   () => GoalsDetail(
                  //     index: 1,
                  //     report: ReportView(ReportList()),
                  //   ),
                  // );
                  Get.toNamed('/goals_detail/$index');
                },
                child: ReportWidget(
                  report: reports, // Pass the individual Report object
                ));
          },
        ),
      ),
    );
  }
}
