part of 'currency_history_bloc.dart';

abstract class CurrencyHistoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CurrencyHistoryInitial extends CurrencyHistoryState {}

class CurrencyHistoryLoading extends CurrencyHistoryState {}

class CurrencyHistoryLoaded extends CurrencyHistoryState {
  final List<CurrencyHistory> history;

  CurrencyHistoryLoaded(this.history);

  @override
  List<Object?> get props => [history];
}

class CurrencyHistoryError extends CurrencyHistoryState {
  final String message;

  CurrencyHistoryError(this.message);

  @override
  List<Object?> get props => [message];
}
