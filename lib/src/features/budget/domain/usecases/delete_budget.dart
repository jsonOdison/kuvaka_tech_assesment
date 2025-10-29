import '../repositories/budget_repository.dart';

class DeleteBudget {
  DeleteBudget(this.repository);
  final BudgetRepository repository;

  Future<void> call(String category) async {
    await repository.deleteBudget(category);
  }
}
