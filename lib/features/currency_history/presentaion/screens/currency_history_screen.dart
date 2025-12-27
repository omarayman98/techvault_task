import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/currency_history_bloc.dart';

class CurrencyHistoryPage extends StatelessWidget {
  final String baseCurrency;
  final List<String> currencies;

  const CurrencyHistoryPage({
    super.key,
    required this.baseCurrency,
    required this.currencies,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency History'),
      ),
      body: BlocBuilder<CurrencyHistoryBloc, CurrencyHistoryState>(
        builder: (context, state) {
          if (state is CurrencyHistoryLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CurrencyHistoryLoaded) {
            final history = state.history;
            return ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                final day = history[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(
                        '${day.date.toIso8601String().split('T')[0]}'),
                    subtitle: Text(day.rates.entries
                        .map((e) => '${e.key}: ${e.value.toStringAsFixed(2)}')
                        .join(', ')),
                  ),
                );
              },
            );
          }

          if (state is CurrencyHistoryError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox();
        },
      ),
    );
  }
}
