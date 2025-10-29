import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuvaka_tech_assesment/src/core/constants/budget_list.dart';
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
                return Dismissible(
                  key: Key(budget.category), // unique identifier
                  direction:
                      DismissDirection.endToStart, // swipe from right to left
                  background: Container(
                    color: Colors.redAccent,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  confirmDismiss: (direction) async {
                    return await showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Delete Budget'),
                        content: Text(
                          'Are you sure you want to delete the budget for "${budget.category}"?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    );
                  },
                  onDismissed: (direction) {
                    context.read<BudgetBloc>().add(
                      DeleteBudgetEvent(budget.category),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${budget.category} budget deleted'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  child: ListTile(
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
    final limitController = TextEditingController(
      text: existing?.limit.toString() ?? '',
    );

    String selectedCategory = existing?.category ?? 'Food';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(existing == null ? 'Add Budget' : 'Update Budget'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: const InputDecoration(labelText: 'Category'),
              items: categories
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (val) => selectedCategory = val!,
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
              final limit = double.tryParse(limitController.text) ?? 0;
              if (limit <= 0) return;

              final budget = BudgetEntity(
                category: selectedCategory,
                limit: limit,
              );

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
