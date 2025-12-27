import '../../domain/entities/currency.dart';
import '../../domain/repositories/currency_repo.dart';
import '../datasources/local_data_source.dart';
import '../datasources/remote_data_source.dart';
import '../models/currency_hive_model.dart';

class CurrencyRepositoryImpl implements CurrencyRepository {
  final CurrencyRemoteDataSource remote;
  final CurrencyLocalDataSource local;

  CurrencyRepositoryImpl(this.remote, this.local);

  @override
  Future<List<Currency>> getSupportedCurrencies() async {
    final cached = await local.getCurrencies();

    if (cached.isNotEmpty) {
      return cached
          .map((e) => Currency(
        code: e.code,
        name: e.name,
        symbol: e.symbol,
      ))
          .toList();
    }

    final remoteCurrencies =
    await remote.getSupportedCurrencies();

    await local.cacheCurrencies(
      remoteCurrencies
          .map(
            (e) => CurrencyHiveModel(
          code: e.code,
          name: e.name,
          symbol: e.symbol,
        ),
      )
          .toList(),
    );

    return remoteCurrencies;
  }
}
