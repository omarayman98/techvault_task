import 'package:hive/hive.dart';
import '../models/currency_hive_model.dart';

abstract class CurrencyLocalDataSource {
  Future<List<CurrencyHiveModel>> getCurrencies();
  Future<void> cacheCurrencies(List<CurrencyHiveModel> currencies);
}

class CurrencyLocalDataSourceImpl
    implements CurrencyLocalDataSource {
  static const boxName = 'currencies_box';

  @override
  Future<List<CurrencyHiveModel>> getCurrencies() async {
    final box = await Hive.openBox<CurrencyHiveModel>(boxName);
    return box.values.toList();
  }

  @override
  Future<void> cacheCurrencies(
      List<CurrencyHiveModel> currencies) async {
    final box = await Hive.openBox<CurrencyHiveModel>(boxName);
    await box.clear();
    await box.addAll(currencies);
  }
}
