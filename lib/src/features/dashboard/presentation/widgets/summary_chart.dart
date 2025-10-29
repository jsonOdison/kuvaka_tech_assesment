import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SummaryChart extends StatelessWidget {
  const SummaryChart({super.key, required this.income, required this.expense});
  final double income;
  final double expense;

  @override
  Widget build(BuildContext context) {
    final total = income + expense;
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            value: expense,
            title: 'Expense ${(expense / total * 100).toStringAsFixed(1)}%',
            color: Colors.red,
          ),
          PieChartSectionData(
            value: income,
            title: 'Income ${(income / total * 100).toStringAsFixed(1)}%',
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
