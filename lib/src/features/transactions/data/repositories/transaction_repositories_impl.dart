import 'package:kuvaka_tech_assesment/src/features/transactions/data/local/transaction_local_data_source.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/domain/entities/transactionl.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  TransactionRepositoryImpl({required this.localDataSource});
  final TransactionLocalDataSource localDataSource;

  @override
  Future<void> addTransaction(TransactionEntity transaction) async {
    await localDataSource.addTransaction(transaction);
  }

  @override
  Future<void> deleteTransaction(String id) async {
    await localDataSource.deleteTransaction(id);
  }

  @override
  Future<List<TransactionEntity>> getAllTransactions() async {
    return await localDataSource.getAllTransactions();
  }
}
