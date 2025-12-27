import '../entities/currency.dart';
import '../repositories/currency_repo.dart';

class GetSupportedCurrencies {
  final CurrencyRepository repository;

  GetSupportedCurrencies(this.repository);

  Future<List<Currency>> call() {
    return repository.getSupportedCurrencies();
  }
}
