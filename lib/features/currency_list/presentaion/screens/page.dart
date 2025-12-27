import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../currency_history/presentaion/bloc/currency_history_bloc.dart';
import '../bloc/currencies_bloc.dart';
import '../bloc/currencies_state.dart';

class CurrencyCombinedPage extends StatefulWidget {
  const CurrencyCombinedPage({super.key});

  @override
  State<CurrencyCombinedPage> createState() => _CurrencyCombinedPageState();
}

class _CurrencyCombinedPageState extends State<CurrencyCombinedPage> {
  String? baseCurrency;
  String? targetCurrency;
  double amount = 1.0;
  double? convertedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Currency Converter + History')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // ---------------- Dropdowns & Amount ----------------
            BlocBuilder<CurrenciesBloc, CurrenciesState>(
              builder: (context, state) {
                if (state is CurrenciesLoaded) {
                  final currencies = state.currencies; // List<Currency>

                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButton<String>(
                              value: baseCurrency ?? currencies.first.code,
                              isExpanded: true,
                              items: currencies
                                  .map((c) => DropdownMenuItem(
                                value: c.code,
                                child: Text('${c.code} - ${c.name}'),
                              ))
                                  .toList(),
                              onChanged: (val) {
                                setState(() {
                                  baseCurrency = val;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: DropdownButton<String>(
                              value: targetCurrency ?? currencies[1].code,
                              isExpanded: true,
                              items: currencies
                                  .map((c) => DropdownMenuItem(
                                value: c.code,
                                child: Text('${c.code} - ${c.name}'),
                              ))
                                  .toList(),
                              onChanged: (val) {
                                setState(() {
                                  targetCurrency = val;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'Amount',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                        onChanged: (val) {
                          setState(() {
                            amount = double.tryParse(val) ?? 1.0;
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          if (baseCurrency != null && targetCurrency != null) {
                            // Convert logic here
                            setState(() {
                              convertedValue = amount * 1.1; // demo
                            });

                            // Load history
                            context.read<CurrencyHistoryBloc>().add(
                              LoadCurrencyHistoryEvent(
                                baseCurrency: baseCurrency!,
                                currencies: [baseCurrency!, targetCurrency!],
                              ),
                            );
                          }
                        },
                        child: const Text('Convert & Load History'),
                      ),
                      if (convertedValue != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            '$amount $baseCurrency = ${convertedValue!.toStringAsFixed(2)} $targetCurrency',
                            style:
                            const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                  );
                }

                if (state is CurrenciesLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return const SizedBox();
              },
            ),
            const Divider(height: 24),
            // ---------------- History ----------------
            Expanded(
              child: BlocBuilder<CurrencyHistoryBloc, CurrencyHistoryState>(
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
                              horizontal: 8, vertical: 4),
                          child: ListTile(
                            title: Text(
                                '${day.date.toIso8601String().split('T')[0]}'),
                            subtitle: Text(day.rates.entries
                                .map((e) =>
                            '${e.key}: ${e.value.toStringAsFixed(2)}')
                                .join(', ')),
                          ),
                        );
                      },
                    );
                  }

                  if (state is CurrencyHistoryError) {
                    return Center(child: Text(state.message));
                  }

                  return const Center(
                      child: Text('Select currencies and convert'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
