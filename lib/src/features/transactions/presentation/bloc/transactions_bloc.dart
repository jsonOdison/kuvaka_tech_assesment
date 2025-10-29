import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/domain/entities/transactionl.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/domain/usecases/add_transaction.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/domain/usecases/delete_transaction.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/domain/usecases/get_all_transaction.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc({
    required this.getAllTransactions,
    required this.addTransaction,
    required this.deleteTransaction,
  }) : super(TransactionInitial()) {
    on<LoadTransactionsEvent>(_onLoadTransactions);
    on<AddTransactionEvent>(_onAddTransaction);
    on<DeleteTransactionEvent>(_onDeleteTransaction);
  }
  final GetAllTransactions getAllTransactions;
  final AddTransaction addTransaction;
  final DeleteTransaction deleteTransaction;

  Future<void> _onLoadTransactions(
    LoadTransactionsEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());
    try {
      final transactions = await getAllTransactions();
      // transactions.add("ASD" as TransactionEntity);
      emit(TransactionLoaded(transactions));
    } catch (_) {
      emit(TransactionError('Failed to load transactions'));
    }
  }

  Future<void> _onAddTransaction(
    AddTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    try {
      await addTransaction(event.transaction);
      add(LoadTransactionsEvent());
    } catch (_) {
      emit(TransactionError('Failed to add transaction'));
    }
  }

  Future<void> _onDeleteTransaction(
    DeleteTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    try {
      await deleteTransaction(event.id);
      add(LoadTransactionsEvent());
    } catch (_) {
      emit(TransactionError('Failed to delete transaction'));
    }
  }
}
