part of 'budget_bloc.dart';

abstract class BudgetEvent extends Equatable {
  const BudgetEvent();
  @override
  List<Object?> get props => [];
}

class LoadBudgetsEvent extends BudgetEvent {}

class AddBudgetEvent extends BudgetEvent {
  const AddBudgetEvent(this.budget);
  final BudgetEntity budget;
  @override
  List<Object?> get props => [budget];
}

class UpdateBudgetEvent extends BudgetEvent {
  const UpdateBudgetEvent(this.budget);
  final BudgetEntity budget;
  @override
  List<Object?> get props => [budget];
}

class DeleteBudgetEvent extends BudgetEvent {
  const DeleteBudgetEvent(this.category);
  final String category;
  @override
  List<Object?> get props => [category];
}
