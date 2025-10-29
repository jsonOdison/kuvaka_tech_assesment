import 'package:hive_flutter/adapters.dart';
import 'package:kuvaka_tech_assesment/src/core/constants/hive_keys.dart';
import 'package:kuvaka_tech_assesment/src/features/budget/data/models/budget_model.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/data/models/transaction_model.dart';

void initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionModelAdapter());
  Hive.registerAdapter(BudgetModelAdapter());
  await Hive.openBox<TransactionModel>(HiveKeys.transactions);
  await Hive.openBox<BudgetModel>(HiveKeys.budgets);
}
