import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:kuvaka_tech_assesment/src/core/constants/hive_keys.dart';
import 'package:kuvaka_tech_assesment/src/core/di/injection_container.dart'
    as di;
import 'package:kuvaka_tech_assesment/src/features/transactions/data/models/transaction_model.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/presentation/bloc/transactions_bloc.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/presentation/pages/transaction_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionModelAdapter());

  await Hive.openBox<TransactionModel>(HiveKeys.transactions);
  await Hive.openBox('budgets'); // imple laters

  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TransactionBloc>(
          create: (_) =>
              di.sl<TransactionBloc>()
                ..add(LoadTransactionsEvent()), // intially load the transaction
        ),
      ],
      child: const MaterialApp(
        title: 'Finance Tracker',
        home: TransactionPage(), // Must be below the provider
      ),
    );
  }
}
