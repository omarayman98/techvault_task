import '../entities/currency_history.dart';

abstract class CurrencyHistoryRepository {
  Future<List<CurrencyHistory>> getLast7DaysHistory({
    required String baseCurrency,
    required List<String> currencies,
  });
}
