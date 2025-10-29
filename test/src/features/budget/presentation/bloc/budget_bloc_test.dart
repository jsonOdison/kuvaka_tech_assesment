import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/domain/entities/transactional_entity.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/domain/usecases/add_transaction.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/domain/usecases/delete_transaction.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/domain/usecases/get_all_transaction.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/presentation/bloc/transactions_bloc.dart';
import 'package:mocktail/mocktail.dart';

// Step 1: Mock classes
class MockGetAllTransactions extends Mock implements GetAllTransactions {}

class MockAddTransaction extends Mock implements AddTransaction {}

class MockDeleteTransaction extends Mock implements DeleteTransaction {}

void main() {
  late TransactionBloc bloc;
  late MockGetAllTransactions mockGetAll;
  late MockAddTransaction mockAdd;
  late MockDeleteTransaction mockDelete;

  setUp(() {
    mockGetAll = MockGetAllTransactions();
    mockAdd = MockAddTransaction();
    mockDelete = MockDeleteTransaction();

    bloc = TransactionBloc(
      getAllTransactions: mockGetAll,
      addTransaction: mockAdd,
      deleteTransaction: mockDelete,
    );
  });

  test('initial state should be TransactionInitial', () {
    expect(bloc.state, TransactionInitial());
  });

  blocTest<TransactionBloc, TransactionState>(
    'emits [TransactionLoading, TransactionLoaded] when LoadTransactionsEvent is added',
    build: () {
      when(() => mockGetAll()).thenAnswer(
        (_) async => [
          TransactionEntity(
            id: '1',
            title: 'Test Transaction',
            amount: 1000,
            category: 'Food',
            date: DateTime.now(),
            isExpense: true,
          ),
        ],
      );
      return bloc;
    },
    act: (bloc) => bloc.add(LoadTransactionsEvent()),
    expect: () => [TransactionLoading(), isA<TransactionLoaded>()],
  );
}
