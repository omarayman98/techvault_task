import 'package:dio/dio.dart';
import 'package:techvault_task/core/utils/AppConstatns.dart';

import '../models/currency_model.dart';

abstract class CurrencyHistoryRemoteDataSource {
  Future<List<CurrencyHistoryModel>> getHistory({
    required String baseCurrency,
    required List<String> currencies,
  });
}

class CurrencyHistoryRemoteDataSourceImpl
    implements CurrencyHistoryRemoteDataSource {
  final Dio dio;

  CurrencyHistoryRemoteDataSourceImpl(this.dio);

  @override
  Future<List<CurrencyHistoryModel>> getHistory({
    required String baseCurrency,
    required List<String> currencies,
  }) async {
    final now = DateTime.now();
    final startDate = now.subtract(const Duration(days: 6));

    final response = await dio.get(
      '${AppConstants().baseUrl}${AppConstants().currenciesHistoryEndpoint}?date=${_formatDate(startDate)}',
      queryParameters: {
        'apikey': AppConstants().apiKey,
        'date': _formatDate(startDate),
        'base_currency': baseCurrency,
        'currencies': currencies.join(','),
      },
    );

    final data = response.data['data'] as Map<String, dynamic>;

    return data.entries.map((entry) {
      return CurrencyHistoryModel.fromJson(
        entry.key,
        entry.value as Map<String, dynamic>,
      );
    }).toList();
  }

  String _formatDate(DateTime date) {
    return date.toIso8601String().split('T').first;
  }
}
