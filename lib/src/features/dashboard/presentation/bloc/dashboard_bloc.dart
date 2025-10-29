import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuvaka_tech_assesment/src/features/dashboard/domain/usecases/get_summary.dart';

part 'dashboard_bloc_event.dart';
part 'dashboard_bloc_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc(this.getSummary) : super(DashboardInitial()) {
    on<LoadDashboardEvent>(_onLoad);
  }
  final GetSummary getSummary;

  Future<void> _onLoad(
    LoadDashboardEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());
    try {
      final data = await getSummary();
      emit(
        DashboardLoaded(
          income: data['income']!,
          expense: data['expense']!,
          balance: data['balance']!,
        ),
      );
    } catch (_) {
      emit(DashboardError('Failed to load summary'));
    }
  }
}
