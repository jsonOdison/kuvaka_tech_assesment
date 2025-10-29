import 'package:kuvaka_tech_assesment/src/features/budget/domain/entities/budget_entiry.dart';

import '../repositories/budget_repository.dart';

class AddBudget {
  AddBudget(this.repository);
  final BudgetRepository repository;

  Future<void> call(BudgetEntity budget) async {
    await repository.addBudget(budget);
  }
}
