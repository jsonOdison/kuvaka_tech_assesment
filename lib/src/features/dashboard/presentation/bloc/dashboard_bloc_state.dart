part of 'dashboard_bloc.dart';

abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  DashboardLoaded({
    required this.income,
    required this.expense,
    required this.balance,
  });
  final double income;
  final double expense;
  final double balance;
}

class DashboardError extends DashboardState {
  DashboardError(this.message);
  final String message;
}
