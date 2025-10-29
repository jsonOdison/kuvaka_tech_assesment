import 'package:equatable/equatable.dart';

class TransactionEntity extends Equatable {
  const TransactionEntity({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.isExpense,
  });
  final String id;
  final String title;
  final double amount;
  final String category; // ← add this
  final DateTime date;
  final bool isExpense;

  @override
  List<Object?> get props => [id, title, amount, category, date, isExpense];
}
