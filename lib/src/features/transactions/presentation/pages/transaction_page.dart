import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/domain/entities/transactionl.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/presentation/bloc/transactions_bloc.dart';
import '../../../../core/di/injection_container.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TransactionBloc>()..add(LoadTransactionsEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Transactions')),
        body: BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            if (state is TransactionLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TransactionLoaded) {
              if (state.transactions.isEmpty) {
                return const Center(child: Text('No transactions found'));
              }
              return ListView.builder(
                itemCount: state.transactions.length,
                itemBuilder: (_, i) {
                  final t = state.transactions[i];
                  return ListTile(
                    title: Text(t.title),
                    subtitle: Text(
                      '${t.category} • ${t.amount.toStringAsFixed(2)}',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
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
            // temporary test add
            final transaction = DateTime.now().millisecondsSinceEpoch
                .toString();
            context.read<TransactionBloc>().add(
              AddTransactionEvent(
                TransactionEntity(
                  id: transaction,
                  title: 'Test $transaction',
                  amount: 50.0,
                  date: DateTime.now(),
                  category: 'General',
                  isExpense: true,
                ),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
