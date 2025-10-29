import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuvaka_tech_assesment/src/features/budget/domain/usecases/get_all_budget.dart';
import 'package:kuvaka_tech_assesment/src/features/dashboard/domain/usecases/get_summary.dart';

part 'dashboard_bloc_event.dart';
part 'dashboard_bloc_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({required this.getSummary, required this.getAllBudgets})
    : super(DashboardInitial()) {
    on<LoadDashboardEvent>(_onLoad);
  }
  final GetSummary getSummary;
  final GetAllBudgets getAllBudgets;

  Future<void> _onLoad(
    LoadDashboardEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());
    try {
      final summary = await getSummary();
      final budgets = await getAllBudgets();

      final income = summary['income'] as double;
      final expense = summary['expense'] as double;
      final balance = summary['balance'] as double;
      final Map<String, double> categoryTotals =
          summary['categoryTotals'] as Map<String, double>;

      final List<String> alerts = [];
      for (final b in budgets) {
        final spent = categoryTotals[b.category] ?? 0;
        if (spent >= b.limit) {
          alerts.add(
            '${b.category} over budget (₹${spent.toStringAsFixed(0)} / ₹${b.limit.toStringAsFixed(0)})',
          );
        } else if (spent >= b.limit * 0.9) {
          alerts.add(
            '${b.category} nearing limit (₹${spent.toStringAsFixed(0)} / ₹${b.limit.toStringAsFixed(0)})',
          );
        }
      }

      emit(
        DashboardLoaded(
          income: income,
          expense: expense,
          balance: balance,
          categoryTotals: categoryTotals,
          alerts: alerts,
        ),
      );
    } catch (e) {
      emit(DashboardError('Failed to load summary: $e'));
    }
  }
}
