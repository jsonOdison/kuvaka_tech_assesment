import 'package:kuvaka_tech_assesment/src/features/transactions/domain/entities/transactional_entity.dart';

import '../repositories/transaction_repository.dart';

class GetAllTransactions {
  GetAllTransactions(this.repository);
  final TransactionRepository repository;

  Future<List<TransactionEntity>> call() async {
    return await repository.getAllTransactions();
  }
}
