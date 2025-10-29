import 'package:hive/hive.dart';
import 'package:kuvaka_tech_assesment/src/features/budget/domain/entities/budget_entiry.dart';
import '../models/budget_model.dart';

abstract class BudgetLocalDataSource {
  Future<void> addBudget(BudgetEntity budget);
  Future<List<BudgetEntity>> getAllBudgets();
  Future<void> updateBudget(BudgetEntity budget);
  Future<void> deleteBudget(String category);
}

class BudgetLocalDataSourceImpl implements BudgetLocalDataSource {
  BudgetLocalDataSourceImpl(this.budgetBox);
  final Box<BudgetModel> budgetBox;

  @override
  Future<void> addBudget(BudgetEntity budget) async {
    final model = BudgetModel.fromEntity(budget);
    await budgetBox.put(model.category, model);
  }

  @override
  Future<List<BudgetEntity>> getAllBudgets() async {
    return budgetBox.values.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> updateBudget(BudgetEntity budget) async {
    if (budgetBox.containsKey(budget.category)) {
      final model = BudgetModel.fromEntity(budget);
      await budgetBox.put(model.category, model);
    } else {
      await budgetBox.put(budget.category, BudgetModel.fromEntity(budget));
    }
  }

  @override
  Future<void> deleteBudget(String category) async {
    await budgetBox.delete(category);
  }
}
