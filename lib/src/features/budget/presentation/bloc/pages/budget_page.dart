import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuvaka_tech_assesment/src/core/utils/number_formatter.dart';
import 'package:kuvaka_tech_assesment/src/features/budget/domain/entities/budget_entiry.dart';
import 'package:kuvaka_tech_assesment/src/features/budget/presentation/bloc/budget_bloc.dart';

class BudgetPage extends StatelessWidget {
  const BudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Budgets')),
      body: BlocBuilder<BudgetBloc, BudgetState>(
        builder: (context, state) {
          if (state is BudgetLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BudgetLoaded) {
            final budgets = state.budgets;

            if (budgets.isEmpty) {
              return const Center(child: Text('No budgets set'));
            }

            return ListView.builder(
              itemCount: budgets.length,
              itemBuilder: (context, index) {
                final budget = budgets[index];
                return ListTile(
                  title: Text(budget.category),
                  subtitle: Text(
                    'Limit: ${NumberFormatter.format(budget.limit)}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      _showBudgetDialog(context, existing: budget);
                    },
                  ),
                );
              },
            );
          } else if (state is BudgetError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showBudgetDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showBudgetDialog(BuildContext context, {BudgetEntity? existing}) {
    final categoryController = TextEditingController(
      text: existing?.category ?? '',
    );
    final limitController = TextEditingController(
      text: existing?.limit.toString() ?? '',
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(existing == null ? 'Add Budget' : 'Update Budget'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            TextField(
              controller: limitController,
              decoration: const InputDecoration(labelText: 'Limit (₹)'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final category = categoryController.text.trim();
              final limit = double.tryParse(limitController.text) ?? 0;
              if (category.isEmpty || limit <= 0) return;

              final budget = BudgetEntity(category: category, limit: limit);

              if (existing == null) {
                context.read<BudgetBloc>().add(AddBudgetEvent(budget));
              } else {
                context.read<BudgetBloc>().add(UpdateBudgetEvent(budget));
              }

              Navigator.pop(context);
            },
            child: Text(existing == null ? 'Add' : 'Update'),
          ),
        ],
      ),
    );
  }
}
