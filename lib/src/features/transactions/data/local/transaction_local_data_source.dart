import 'package:hive/hive.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/data/models/transaction_model.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/domain/entities/transactionl.dart';

abstract class TransactionLocalDataSource {
  Future<void> addTransaction(TransactionEntity transaction);
  Future<void> deleteTransaction(String id);
  Future<List<TransactionEntity>> getAllTransactions();
}

class TransactionLocalDataSourceImpl implements TransactionLocalDataSource {
  final Box<TransactionModel> transactionBox;

  TransactionLocalDataSourceImpl(this.transactionBox);

  @override
  Future<void> addTransaction(TransactionEntity transaction) async {
    final model = TransactionModel.fromEntity(transaction);
    await transactionBox.put(model.id, model);
  }

  @override
  Future<void> deleteTransaction(String id) async {
    await transactionBox.delete(id);
  }

  @override
  Future<List<TransactionEntity>> getAllTransactions() async {
    final models = transactionBox.values.toList();
    return models.map((m) => m.toEntity()).toList();
  }
}
