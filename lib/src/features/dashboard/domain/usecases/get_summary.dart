import '../../../transactions/domain/repositories/transaction_repository.dart';

class GetSummary {
  GetSummary(this.repository);
  final TransactionRepository repository;

  Future<Map<String, double>> call() async {
    final txs = await repository.getAllTransactions();
    double totalIncome = 0;
    double totalExpense = 0;
    for (final t in txs) {
      if (t.isExpense) {
        totalExpense += t.amount;
      } else {
        totalIncome += t.amount;
      }
    }
    return {
      'income': totalIncome,
      'expense': totalExpense,
      'balance': totalIncome - totalExpense,
    };
  }
}
