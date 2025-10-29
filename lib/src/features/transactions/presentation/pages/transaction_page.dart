import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kuvaka_tech_assesment/src/core/utils/number_formatter.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/presentation/bloc/transactions_bloc.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/presentation/widgets/add_transaction_dialog.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/presentation/widgets/export_csv_button.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        actions: const [ExportCsvButton()],
      ),
      body: BlocListener<TransactionBloc, TransactionState>(
        listener: (context, state) {
          if (state is TransactionLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Transactions updated'),
                duration: Duration(seconds: 1),
              ),
            );
          } else if (state is TransactionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.redAccent,
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        child: BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            // loading indicator
            if (state is TransactionLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            // loaded state
            else if (state is TransactionLoaded) {
              final transactions = state.transactions;

              if (transactions.isEmpty) {
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<TransactionBloc>().add(
                      LoadTransactionsEvent(),
                    );
                    await Future.delayed(const Duration(milliseconds: 800));
                  },
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.inbox_outlined,
                                size: 64,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'No transactions yet',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Pull down to refresh or tap + to add one',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<TransactionBloc>().add(LoadTransactionsEvent());
                  await Future.delayed(const Duration(milliseconds: 800));
                },
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final t = transactions[index];
                    return Dismissible(
                      key: Key(t.id),
                      direction:
                          DismissDirection.endToStart, // swipe left to delete
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
                            title: const Text('Delete Transaction'),
                            content: Text(
                              'Delete "${t.title}" from ${t.category}?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: const Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                        );
                      },
                      onDismissed: (direction) {
                        context.read<TransactionBloc>().add(
                          DeleteTransactionEvent(t.id),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${t.title} deleted'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      child: ListTile(
                        title: Text(t.title),
                        subtitle: Text(
                          '${t.category} • ${DateFormat.yMMMd().format(t.date)}',
                        ),
                        trailing: Text(
                          NumberFormatter.format(t.amount),
                          style: TextStyle(
                            color: t.isExpense ? Colors.red : Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            // error state — now scrollable and refreshable
            else if (state is TransactionError) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<TransactionBloc>().add(LoadTransactionsEvent());
                  await Future.delayed(const Duration(milliseconds: 800));
                },
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 60,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              state.message,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(color: Colors.redAccent),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Pull down to retry',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            // fallback
            return const SizedBox.shrink();
          },
        ),
      ),

      // add new transaction
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
