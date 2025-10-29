import 'package:kuvaka_tech_assesment/src/features/transactions/domain/entities/transactionl.dart';

abstract class TransactionRepository {
  Future<void> addTransaction(TransactionEntity transaction);
  Future<void> deleteTransaction(String id);
  Future<List<TransactionEntity>> getAllTransactions();
}
