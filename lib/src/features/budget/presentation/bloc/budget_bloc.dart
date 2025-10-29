import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuvaka_tech_assesment/src/features/budget/domain/entities/budget_entiry.dart';
import 'package:kuvaka_tech_assesment/src/features/budget/domain/usecases/add_budget.dart';
import 'package:kuvaka_tech_assesment/src/features/budget/domain/usecases/delete_budget.dart';
import 'package:kuvaka_tech_assesment/src/features/budget/domain/usecases/get_all_budget.dart';
import 'package:kuvaka_tech_assesment/src/features/budget/domain/usecases/update_budget.dart';

part 'budget_event.dart';
part 'budget_state.dart';

class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  BudgetBloc({
    required this.addBudget,
    required this.getAllBudgets,
    required this.updateBudget,
    required this.deleteBudget,
  }) : super(BudgetInitial()) {
    on<LoadBudgetsEvent>(_onLoadBudgets);
    on<AddBudgetEvent>(_onAddBudget);
    on<UpdateBudgetEvent>(_onUpdateBudget);
    on<DeleteBudgetEvent>(_onDeleteBudget);
  }
  final AddBudget addBudget;
  final GetAllBudgets getAllBudgets;
  final UpdateBudget updateBudget;
  final DeleteBudget deleteBudget;

  Future<void> _onLoadBudgets(
    LoadBudgetsEvent event,
    Emitter<BudgetState> emit,
  ) async {
    emit(BudgetLoading());
    try {
      final budgets = await getAllBudgets();
      emit(BudgetLoaded(budgets));
    } catch (e) {
      emit(BudgetError('Failed to load budgets: $e'));
    }
  }

  Future<void> _onAddBudget(
    AddBudgetEvent event,
    Emitter<BudgetState> emit,
  ) async {
    try {
      await addBudget(event.budget);
      final budgets = await getAllBudgets();
      emit(BudgetLoaded(budgets));
    } catch (e) {
      emit(BudgetError('Failed to add budget: $e'));
    }
  }

  Future<void> _onUpdateBudget(
    UpdateBudgetEvent event,
    Emitter<BudgetState> emit,
  ) async {
    try {
      await updateBudget(event.budget);
      final budgets = await getAllBudgets();
      emit(BudgetLoaded(budgets));
    } catch (e) {
      emit(BudgetError('Failed to update budget: $e'));
    }
  }

  Future<void> _onDeleteBudget(
    DeleteBudgetEvent event,
    Emitter<BudgetState> emit,
  ) async {
    try {
      await deleteBudget(event.category);
      final budgets = await getAllBudgets();
      emit(BudgetLoaded(budgets));
    } catch (e) {
      emit(BudgetError('Failed to delete budget: $e'));
    }
  }
}
