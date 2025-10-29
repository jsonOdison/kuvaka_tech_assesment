import 'package:kuvaka_tech_assesment/src/features/transactions/domain/entities/transactionl.dart';

import '../repositories/transaction_repository.dart';

class AddTransaction {
  AddTransaction(this.repository);
  final TransactionRepository repository;

  Future<void> call(TransactionEntity transaction) async {
    await repository.addTransaction(transaction);
  }
}
