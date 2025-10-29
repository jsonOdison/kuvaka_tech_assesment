import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/transactional_entity.dart';
import '../bloc/transactions_bloc.dart';

class AddTransactionDialog extends StatefulWidget {
  const AddTransactionDialog({super.key});

  @override
  State<AddTransactionDialog> createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  String _selectedCategory = 'Food';
  bool _isExpense = true;

  final List<String> _categories = [
    'Food',
    'Bills',
    'Travel',
    'Shopping',
    'Health',
    'Salary',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Transaction'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Amount'),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: _selectedCategory,
            decoration: const InputDecoration(labelText: 'Category'),
            items: _categories
                .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                .toList(),
            onChanged: (val) => setState(() => _selectedCategory = val!),
          ),
          SwitchListTile(
            title: const Text('Expense?'),
            value: _isExpense,
            onChanged: (val) => setState(() => _isExpense = val),
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
            final title = _titleController.text.trim();
            final amount = double.tryParse(_amountController.text) ?? 0;
            if (title.isEmpty || amount <= 0) return;

            final transaction = TransactionEntity(
              id: Uuid().v4(),
              title: title,
              amount: amount,
              category: _selectedCategory,
              date: DateTime.now(),
              isExpense: _isExpense,
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
}
