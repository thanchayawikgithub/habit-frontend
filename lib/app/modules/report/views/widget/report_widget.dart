import 'package:flutter/material.dart';

import 'package:habit_frontend/app/modules/report/report.dart';
import 'package:habit_frontend/app/modules/report/views/widget/report_list.dart';

class ReportWidget extends StatelessWidget {
  final Report report;

  const ReportWidget({
    super.key,
    required this.report,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Progress indicator
            SizedBox(
              width: 60,
              height: 60,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: report.progress / 100,
                    strokeWidth: 6,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      report.status == 'Achieved' ? Colors.green : Colors.grey,
                    ),
                  ),
                  Center(
                    child: Text(
                      '${report.progress}%',
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            // Report details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    report.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    report.target,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            // Status
            Container(
              decoration: BoxDecoration(
                color: report.status == 'Achieved'
                    ? Colors.green[100]
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Text(
                report.status,
                style: TextStyle(
                  color:
                      report.status == 'Achieved' ? Colors.green : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReportListScreen extends StatelessWidget {
  late final ReportList list;

  ReportListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.reportData.length,
      itemBuilder: (context, index) {
        final ReportItem =
            list.reportData[index]; // Get each Report from ReportData
        return ReportWidget(
            report: ReportItem); // Pass the Report object to ReportWidget
      },
    );
  }
}
