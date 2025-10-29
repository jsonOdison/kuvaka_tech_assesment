part of 'dashboard_bloc.dart';

abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  DashboardLoaded({
    required this.income,
    required this.expense,
    required this.balance,
    required this.categoryTotals,
    required this.alerts,
  });
  final double income;
  final double expense;
  final double balance;
  final Map<String, double> categoryTotals;
  final List<String> alerts;
}

class DashboardError extends DashboardState {
  DashboardError(this.message);
  final String message;
}
