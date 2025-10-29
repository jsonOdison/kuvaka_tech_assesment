import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/presentation/bloc/transactions_bloc.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/presentation/utils/export_csv.dart';

class ExportCsvButton extends StatelessWidget {
  const ExportCsvButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state is TransactionLoaded && state.transactions.isNotEmpty) {
          return IconButton(
            icon: const Icon(Icons.download),
            tooltip: 'Export to CSV',
            onPressed: () async {
              // Capture messenger reference BEFORE any await
              final messenger = ScaffoldMessenger.of(context);
              try {
                final path = await TransactionCsvExporter.export(
                  state.transactions,
                );
                messenger.showSnackBar(
                  SnackBar(content: Text('CSV exported to: $path')),
                );
              } catch (e) {
                messenger.showSnackBar(
                  SnackBar(
                    content: Text('Export failed: $e'),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              }
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
