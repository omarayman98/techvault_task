import '../../domain/entities/currency_history.dart';
import '../../domain/repositories/currency_repo.dart';
import '../datasources/remote_data_source.dart';

class CurrencyHistoryRepositoryImpl
    implements CurrencyHistoryRepository {
  final CurrencyHistoryRemoteDataSource remoteDataSource;

  CurrencyHistoryRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<CurrencyHistory>> getLast7DaysHistory({
    required String baseCurrency,
    required List<String> currencies,
  }) {
    return remoteDataSource.getHistory(
      baseCurrency: baseCurrency,
      currencies: currencies,
    );
  }
}
