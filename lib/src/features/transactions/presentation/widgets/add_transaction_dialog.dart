import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/domain/entities/transactionl.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/presentation/bloc/transactions_bloc.dart';

class AddTransactionDialog extends StatefulWidget {
  const AddTransactionDialog({super.key});

  @override
  State<AddTransactionDialog> createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  bool isExpense = true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Transaction'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Amount'),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Expense'),
              Switch(
                value: !isExpense,
                onChanged: (val) => setState(() => isExpense = !val),
              ),
              const Text('Income'),
            ],
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
            final title = titleController.text.trim();
            final amount = double.tryParse(amountController.text) ?? 0.0;

            if (title.isEmpty || amount <= 0) return;

            final transaction = TransactionEntity(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              title: title,
              amount: amount,
              date: DateTime.now(),
              category: isExpense ? 'Expense' : 'Income',
              isExpense: isExpense,
            );

            context.read<TransactionBloc>().add(
              AddTransactionEvent(transaction),
            );
            Navigator.pop(context);
          },
          child: const Text('Add'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }
}
