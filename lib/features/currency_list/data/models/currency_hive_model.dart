import 'package:hive/hive.dart';
part 'currency_hive_model.g.dart';

@HiveType(typeId: 0)
class CurrencyHiveModel extends HiveObject {
  @HiveField(0)
  final String code;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String symbol;

  CurrencyHiveModel({
    required this.code,
    required this.name,
    required this.symbol,
  });
}
