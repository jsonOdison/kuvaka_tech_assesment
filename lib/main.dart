import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:kuvaka_tech_assesment/src/core/constants/hive_keys.dart';
import 'package:kuvaka_tech_assesment/src/core/di/injection_container.dart'
    as di;
import 'package:kuvaka_tech_assesment/src/features/transactions/data/models/transaction_model.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/presentation/pages/transaction_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionModelAdapter());

  await Hive.openBox<TransactionModel>(HiveKeys.transactions);
  await Hive.openBox('budgets'); // imple laters

  await di.init();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: const TransactionPage(),
    );
  }
}
