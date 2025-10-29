part of 'transactions_bloc.dart';

abstract class TransactionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionLoaded extends TransactionState {
  TransactionLoaded(this.transactions);
  final List<TransactionEntity> transactions;
  @override
  List<Object?> get props => [transactions];
}

class TransactionError extends TransactionState {
  TransactionError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
