import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:kuvaka_tech_assesment/src/core/constants/hive_keys.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // hive box instance
  final transactionBox = Hive.box(HiveKeys.transactions);
}
