import 'dart:io';

import 'package:csv/csv.dart';
import 'package:intl/intl.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/domain/entities/transactional_entity.dart';

class TransactionCsvExporter {
  static Future<String> export(List<TransactionEntity> transactions) async {
    if (transactions.isEmpty) {
      throw Exception('No transactions to export');
    }

    final rows = <List<dynamic>>[
      ['ID', 'Title', 'Amount', 'Category', 'Date', 'Type'],
      for (final t in transactions)
        [
          t.id,
          t.title,
          t.amount,
          t.category,
          DateFormat('yyyy-MM-dd').format(t.date),
          t.isExpense ? 'Expense' : 'Income',
        ],
    ];

    final csvData = const ListToCsvConverter().convert(rows);

    final dir = Directory('/storage/emulated/0/Download');
    final path = '${dir.path}/transactions_export.csv';
    final file = File(path);
    await file.writeAsString(csvData);

    return path;
  }
}
