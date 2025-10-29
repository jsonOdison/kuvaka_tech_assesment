import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:kuvaka_tech_assesment/src/core/constants/hive_keys.dart';
import 'package:kuvaka_tech_assesment/src/features/dashboard/domain/usecases/get_summary.dart';
import 'package:kuvaka_tech_assesment/src/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/data/local/transaction_local_data_source.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/data/models/transaction_model.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/domain/repositories/transaction_repository_impl.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/domain/usecases/add_transaction.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/domain/usecases/delete_transaction.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/domain/usecases/get_all_transaction.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/presentation/bloc/transactions_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // hive box instance
  final transactionBox = Hive.box<TransactionModel>(HiveKeys.transactions);

  // Data source
  sl.registerLazySingleton<TransactionLocalDataSource>(
    () => TransactionLocalDataSourceImpl(transactionBox),
  );

  // Repository
  sl.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(localDataSource: sl()),
  );

  // use cases
  sl.registerLazySingleton(() => GetAllTransactions(sl()));
  sl.registerLazySingleton(() => AddTransaction(sl()));
  sl.registerLazySingleton(() => DeleteTransaction(sl()));

  sl.registerLazySingleton(() => GetSummary(sl()));

  // bloc use cases
  sl.registerFactory(
    () => TransactionBloc(
      getAllTransactions: sl(),
      addTransaction: sl(),
      deleteTransaction: sl(),
    ),
  );

  sl.registerFactory(() => DashboardBloc(sl()));
}
