import 'package:dio/dio.dart';
import '../../../../core/utils/AppConstatns.dart';
import '../models/currency_model.dart';

abstract class CurrencyRemoteDataSource {
  Future<List<CurrencyModel>> getSupportedCurrencies();
}

class CurrencyRemoteDataSourceImpl
    implements CurrencyRemoteDataSource {
  final Dio dio;

  CurrencyRemoteDataSourceImpl(this.dio);

  @override
  Future<List<CurrencyModel>> getSupportedCurrencies() async {
    final response = await dio.get(
      '${AppConstants().baseUrl}${AppConstants().currenciesEndpoint}',
      queryParameters: {
        'apikey': AppConstants().apiKey,
      },
    );

    final data = response.data['data'] as Map<String, dynamic>;

    return data.values
        .map((json) => CurrencyModel.fromJson(json))
        .toList();
  }
}
