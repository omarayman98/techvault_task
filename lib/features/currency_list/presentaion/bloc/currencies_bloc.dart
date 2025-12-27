import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/currency_usecase.dart';
import 'currencies_event.dart';
import 'currencies_state.dart';

class CurrenciesBloc
    extends Bloc<CurrenciesEvent, CurrenciesState> {
  final GetSupportedCurrencies getSupportedCurrencies;

  CurrenciesBloc(this.getSupportedCurrencies)
      : super(CurrenciesInitial()) {
    on<LoadCurrenciesEvent>(_onLoadCurrencies);
  }

  Future<void> _onLoadCurrencies(
      LoadCurrenciesEvent event,
      Emitter<CurrenciesState> emit,
      ) async {
    emit(CurrenciesLoading());

    try {
      final currencies = await getSupportedCurrencies();
      emit(CurrenciesLoaded(currencies));
    } catch (e) {
      emit(const CurrenciesError('Failed to load currencies'));
    }
  }
}
