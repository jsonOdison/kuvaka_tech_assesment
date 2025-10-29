import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:kuvaka_tech_assesment/src/core/constants/hive_keys.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/data/local/transaction_local_data_source.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/data/models/transaction_model.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/domain/repositories/transaction_repository_impl.dart';

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
}
