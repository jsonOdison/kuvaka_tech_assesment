part of 'transactions_bloc.dart';

abstract class TransactionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadTransactionsEvent extends TransactionEvent {}

class AddTransactionEvent extends TransactionEvent {
  AddTransactionEvent(this.transaction);
  final TransactionEntity transaction;
  @override
  List<Object?> get props => [transaction];
}

class DeleteTransactionEvent extends TransactionEvent {
  DeleteTransactionEvent(this.id);
  final String id;
  @override
  List<Object?> get props => [id];
}
