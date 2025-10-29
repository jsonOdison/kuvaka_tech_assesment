import '../../../transactions/domain/repositories/transaction_repository.dart';

class GetSummary {
  GetSummary(this.repository);
  final TransactionRepository repository;

  Future<Map<String, dynamic>> call() async {
    final transactions = await repository.getAllTransactions();

    double income = 0;
    double expense = 0;
    final Map<String, double> categoryTotals = {};

    for (final t in transactions) {
      if (t.isExpense) {
        expense += t.amount;
        categoryTotals[t.category] =
            (categoryTotals[t.category] ?? 0) + t.amount;
      } else {
        income += t.amount;
      }
    }

    final balance = income - expense;

    return {
      'income': income,
      'expense': expense,
      'balance': balance,
      'categoryTotals': categoryTotals,
    };
  }
}
