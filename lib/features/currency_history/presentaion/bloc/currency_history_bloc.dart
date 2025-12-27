import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/currency_history.dart';
import '../../domain/usecases/currency_usecase.dart';

part 'currency_history_event.dart';

part 'currency_history_state.dart';

class CurrencyHistoryBloc
    extends Bloc<CurrencyHistoryEvent, CurrencyHistoryState> {
  final GetCurrencyHistory getCurrencyHistory;

  CurrencyHistoryBloc(this.getCurrencyHistory)
      : super(CurrencyHistoryInitial()) {
    on<LoadCurrencyHistoryEvent>(_onLoadHistory);
  }
  Future<void> _onLoadHistory(
      LoadCurrencyHistoryEvent event,
      Emitter<CurrencyHistoryState> emit,
      ) async {
    emit(CurrencyHistoryLoading());

    try {
      final history = await getCurrencyHistory(
        baseCurrency: event.baseCurrency,
        currencies: event.currencies,
      );

      emit(CurrencyHistoryLoaded(history));
    } catch (e) {
      emit(
        CurrencyHistoryError('Failed to load currency history'),
      );
    }
  }
}
