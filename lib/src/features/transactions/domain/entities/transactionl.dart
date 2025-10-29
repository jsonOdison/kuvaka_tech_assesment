class TransactionEntity {
  const TransactionEntity({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    required this.isExpense,
  });
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String category;
  final bool isExpense;
}
