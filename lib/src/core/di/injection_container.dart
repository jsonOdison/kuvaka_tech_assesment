import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:kuvaka_tech_assesment/src/core/app_theme/theme_cubit.dart';
import 'package:kuvaka_tech_assesment/src/core/constants/hive_keys.dart';
import 'package:kuvaka_tech_assesment/src/features/budget/data/data_source/budget_local_data_source.dart';
import 'package:kuvaka_tech_assesment/src/features/budget/data/models/budget_model.dart';
import 'package:kuvaka_tech_assesment/src/features/budget/data/repositories/budget_repositories_impl.dart';
import 'package:kuvaka_tech_assesment/src/features/budget/domain/repositories/budget_repository.dart';
import 'package:kuvaka_tech_assesment/src/features/budget/domain/usecases/add_budget.dart';
import 'package:kuvaka_tech_assesment/src/features/budget/domain/usecases/delete_budget.dart';
import 'package:kuvaka_tech_assesment/src/features/budget/domain/usecases/get_all_budget.dart';
import 'package:kuvaka_tech_assesment/src/features/budget/domain/usecases/update_budget.dart';
import 'package:kuvaka_tech_assesment/src/features/budget/presentation/bloc/budget_bloc.dart';
import 'package:kuvaka_tech_assesment/src/features/dashboard/domain/usecases/get_summary.dart';
import 'package:kuvaka_tech_assesment/src/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/data/local/transaction_local_data_source.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/data/models/transaction_model.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/data/repositories/transaction_repositories_impl.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/domain/usecases/add_transaction.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/domain/usecases/delete_transaction.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/domain/usecases/get_all_transaction.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/presentation/bloc/transactions_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // hive box instance
  final transactionBox = Hive.box<TransactionModel>(HiveKeys.transactions);
  final budgetBox = Hive.box<BudgetModel>(HiveKeys.budgets);

  // Data source
  sl.registerLazySingleton<TransactionLocalDataSource>(
    () => TransactionLocalDataSourceImpl(transactionBox),
  );
  sl.registerLazySingleton<BudgetLocalDataSource>(
    () => BudgetLocalDataSourceImpl(budgetBox),
  );

  // Repository
  sl.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(localDataSource: sl()),
  );

  sl.registerLazySingleton<BudgetRepository>(() => BudgetRepositoryImpl(sl()));

  // use cases
  //transaction
  sl.registerLazySingleton(() => GetAllTransactions(sl()));
  sl.registerLazySingleton(() => AddTransaction(sl()));
  sl.registerLazySingleton(() => DeleteTransaction(sl()));
  //dashboard
  sl.registerLazySingleton(() => GetSummary(sl()));
  //budget
  sl.registerLazySingleton(() => AddBudget(sl()));
  sl.registerLazySingleton(() => GetAllBudgets(sl()));
  sl.registerLazySingleton(() => UpdateBudget(sl()));
  sl.registerLazySingleton(() => DeleteBudget(sl()));

  // bloc use cases
  sl.registerFactory(
    () => TransactionBloc(
      getAllTransactions: sl(),
      addTransaction: sl(),
      deleteTransaction: sl(),
    ),
  );
  sl.registerFactory(
    () => BudgetBloc(
      addBudget: sl(),
      getAllBudgets: sl(),
      updateBudget: sl(),
      deleteBudget: sl(),
    ),
  );

  sl.registerFactory(
    () => DashboardBloc(getSummary: sl(), getAllBudgets: sl()),
  );

  // light mode or dark
  sl.registerLazySingleton(() => ThemeCubit());
}
