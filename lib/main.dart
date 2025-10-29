import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuvaka_tech_assesment/src/app_scaffold.dart';
import 'package:kuvaka_tech_assesment/src/core/app_theme/theme_cubit.dart';
import 'package:kuvaka_tech_assesment/src/core/database/hive_init.dart';
import 'package:kuvaka_tech_assesment/src/core/di/injection_container.dart'
    as di;
import 'package:kuvaka_tech_assesment/src/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:kuvaka_tech_assesment/src/features/transactions/presentation/bloc/transactions_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initHive();

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
