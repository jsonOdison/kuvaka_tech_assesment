import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:kuvaka_tech_assesment/src/app_scaffold.dart';
import 'package:kuvaka_tech_assesment/src/core/app_theme/theme_cubit.dart';
import 'package:kuvaka_tech_assesment/src/core/constants/hive_keys.dart';
import 'package:kuvaka_tech_assesment/src/core/di/injection_container.dart'
    as di;
import 'package:kuvaka_tech_assesment/src/features/budget/data/models/budget_model.dart';
import 'package:kuvaka_tech_assesment/src/features/budget/presentation/bloc/budget_bloc.dart';
import 'package:kuvaka_tech_assesment/src/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/data/models/transaction_model.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/presentation/bloc/transactions_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  // 2. Register adapters
  Hive.registerAdapter(TransactionModelAdapter());
  Hive.registerAdapter(BudgetModelAdapter());

  // 3. Open all boxes
  await Hive.openBox<TransactionModel>(HiveKeys.transactions);
  await Hive.openBox<BudgetModel>(HiveKeys.budgets);

  await di.init();

  runApp(const AppBootstrap());
}

class AppBootstrap extends StatelessWidget {
  const AppBootstrap({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<ThemeCubit>()..loadTheme()),
        BlocProvider(
          create: (_) => di.sl<TransactionBloc>()..add(LoadTransactionsEvent()),
        ),
        BlocProvider(
          create: (_) => di.sl<DashboardBloc>()..add(LoadDashboardEvent()),
        ),
        BlocProvider(
          create: (_) => di.sl<BudgetBloc>()..add(LoadBudgetsEvent()),
        ),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, theme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Finance Tracker',
          theme: theme,
          home: const AppScaffold(),
        );
      },
    );
  }
}
