part of 'currency_history_bloc.dart';

@immutable
abstract class CurrencyHistoryEvent {}

class LoadCurrencyHistoryEvent extends CurrencyHistoryEvent {
  final String baseCurrency;
  final List<String> currencies;

  LoadCurrencyHistoryEvent({
    required this.baseCurrency,
    required this.currencies,
  });
}
