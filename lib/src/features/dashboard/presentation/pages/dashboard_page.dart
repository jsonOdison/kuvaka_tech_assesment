import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuvaka_tech_assesment/src/features/dashboard/presentation/widgets/theme_toggle_button.dart';
import '../../../../core/di/injection_container.dart';
import '../bloc/dashboard_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<DashboardBloc>()..add(LoadDashboardEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          actions: [const ThemeToggleButton()],
        ),
        body: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoaded) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Balance: ₹${state.balance.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text('Income: ₹${state.income.toStringAsFixed(2)}'),
                    Text('Expense: ₹${state.expense.toStringAsFixed(2)}'),
                    const SizedBox(height: 20),

                    // Pie Chart for Category Totals
                    if (state.categoryTotals.isNotEmpty)
                      SizedBox(
                        height: 200,
                        child: PieChart(
                          PieChartData(
                            sections: state.categoryTotals.entries.map((entry) {
                              return PieChartSectionData(
                                title: entry.key,
                                value: entry.value,
                                radius: 50,
                              );
                            }).toList(),
                          ),
                        ),
                      ),

                    const SizedBox(height: 20),
                    if (state.alerts.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Budget Alerts',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(height: 10),
                          for (final a in state.alerts)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Text(
                                a,
                                style: const TextStyle(color: Colors.redAccent),
                              ),
                            ),
                        ],
                      ),
                  ],
                ),
              );
            } else if (state is DashboardError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
