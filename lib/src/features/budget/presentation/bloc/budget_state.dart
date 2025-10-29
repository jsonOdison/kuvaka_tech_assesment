part of 'budget_bloc.dart';

abstract class BudgetState extends Equatable {
  const BudgetState();
  @override
  List<Object?> get props => [];
}

class BudgetInitial extends BudgetState {}

class BudgetLoading extends BudgetState {}

class BudgetLoaded extends BudgetState {
  const BudgetLoaded(this.budgets);
  final List<BudgetEntity> budgets;
  @override
  List<Object?> get props => [budgets];
}

class BudgetError extends BudgetState {
  const BudgetError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
