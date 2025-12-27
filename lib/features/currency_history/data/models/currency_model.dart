import '../../domain/entities/currency_history.dart';

class CurrencyHistoryModel extends CurrencyHistory {
  CurrencyHistoryModel({
    required super.date,
    required super.rates,
  });

  factory CurrencyHistoryModel.fromJson(
      String date,
      Map<String, dynamic> json,
      ) {
    return CurrencyHistoryModel(
      date: DateTime.parse(date),
      rates: json.map(
            (key, value) => MapEntry(key, (value as num).toDouble()),
      ),
    );
  }
}
