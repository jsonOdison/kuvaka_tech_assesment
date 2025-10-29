import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuvaka_tech_assesment/src/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/domain/entities/transactionl.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/presentation/bloc/transactions_bloc.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/presentation/widgets/add_transaction_dialog.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final sampleTransactions = [
    TransactionEntity(
      id: '1',
      title: 'Salary',
      amount: 50000,
      date: DateTime.now(),
      category: 'Income',
      isExpense: false,
    ),
    TransactionEntity(
      id: '2',
      title: 'Freelance',
      amount: 15000,
      date: DateTime.now(),
      category: 'Income',
      isExpense: false,
    ),
    TransactionEntity(
      id: '3',
      title: 'Groceries',
      amount: 4000,
      date: DateTime.now(),
      category: 'Food',
      isExpense: true,
    ),
    TransactionEntity(
      id: '4',
      title: 'Rent',
      amount: 12000,
      date: DateTime.now(),
      category: 'Housing',
      isExpense: true,
    ),
    TransactionEntity(
      id: '5',
      title: 'Utilities',
      amount: 2000,
      date: DateTime.now(),
      category: 'Bills',
      isExpense: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    for (final tx in sampleTransactions) {
      context.read<TransactionBloc>().add(AddTransactionEvent(tx));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.dashboard),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DashboardPage()),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TransactionLoaded) {
            if (state.transactions.isEmpty) {
              return const Center(child: Text('No transactions yet'));
            }

            return ListView.builder(
              itemCount: state.transactions.length,
              itemBuilder: (context, index) {
                final t = state.transactions[index];
                return ListTile(
                  title: Text(t.title),
                  subtitle: Text(
                    '${t.category} • ${t.amount.toStringAsFixed(2)}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () {
                      context.read<TransactionBloc>().add(
                        DeleteTransactionEvent(t.id),
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is TransactionError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => const AddTransactionDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
