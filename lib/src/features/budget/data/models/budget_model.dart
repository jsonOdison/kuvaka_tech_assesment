import 'package:hive/hive.dart';
import 'package:kuvaka_tech_assesment/src/features/budget/domain/entities/budget_entiry.dart';

part 'budget_model.g.dart';

@HiveType(typeId: 2)
class BudgetModel extends HiveObject {
  BudgetModel({required this.category, required this.limit});

  // Map conversions
  factory BudgetModel.fromEntity(BudgetEntity entity) =>
      BudgetModel(category: entity.category, limit: entity.limit);
  @HiveField(0)
  String category;

  @HiveField(1)
  double limit;

  BudgetEntity toEntity() => BudgetEntity(category: category, limit: limit);
}
