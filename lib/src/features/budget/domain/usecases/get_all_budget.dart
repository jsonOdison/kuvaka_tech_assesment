import 'package:kuvaka_tech_assesment/src/features/budget/domain/entities/budget_entiry.dart';

import '../repositories/budget_repository.dart';

class GetAllBudgets {
  GetAllBudgets(this.repository);
  final BudgetRepository repository;

  Future<List<BudgetEntity>> call() async {
    return repository.getAllBudgets();
  }
}
