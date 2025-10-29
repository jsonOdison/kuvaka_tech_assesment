import 'package:kuvaka_tech_assesment/src/features/budget/data/data_source/budget_local_data_source.dart';
import 'package:kuvaka_tech_assesment/src/features/budget/domain/entities/budget_entiry.dart';

import '../../domain/repositories/budget_repository.dart';

class BudgetRepositoryImpl implements BudgetRepository {
  BudgetRepositoryImpl(this.localDataSource);
  final BudgetLocalDataSource localDataSource;

  @override
  Future<void> addBudget(BudgetEntity budget) async {
    await localDataSource.addBudget(budget);
  }

  @override
  Future<List<BudgetEntity>> getAllBudgets() async {
    return localDataSource.getAllBudgets();
  }

  @override
  Future<void> updateBudget(BudgetEntity budget) async {
    await localDataSource.updateBudget(budget);
  }

  @override
  Future<void> deleteBudget(String category) async {
    await localDataSource.deleteBudget(category);
  }
}
