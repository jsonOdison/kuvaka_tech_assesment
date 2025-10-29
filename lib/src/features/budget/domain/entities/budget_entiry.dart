import 'package:equatable/equatable.dart';

class BudgetEntity extends Equatable {
  const BudgetEntity({required this.category, required this.limit});
  final String category;
  final double limit;

  @override
  List<Object?> get props => [category, limit];
}
