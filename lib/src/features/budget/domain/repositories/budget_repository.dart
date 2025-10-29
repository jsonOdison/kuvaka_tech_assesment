import 'package:kuvaka_tech_assesment/src/features/budget/domain/entities/budget_entiry.dart';

abstract class BudgetRepository {
  Future<void> addBudget(BudgetEntity budget);
  Future<List<BudgetEntity>> getAllBudgets();
  Future<void> updateBudget(BudgetEntity budget);
  Future<void> deleteBudget(String category);
}
