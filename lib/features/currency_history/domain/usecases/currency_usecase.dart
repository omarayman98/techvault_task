import '../entities/currency_history.dart';
import '../repositories/currency_repo.dart';

class GetCurrencyHistory {
  final CurrencyHistoryRepository repository;

  GetCurrencyHistory(this.repository);

  Future<List<CurrencyHistory>> call({
    required String baseCurrency,
    required List<String> currencies,
  }) {
    return repository.getLast7DaysHistory(
      baseCurrency: baseCurrency,
      currencies: currencies,
    );
  }
}
