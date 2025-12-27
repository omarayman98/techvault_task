import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/currencies_bloc.dart';
import '../bloc/currencies_event.dart';
import '../bloc/currencies_state.dart';

class CurrenciesPage extends StatelessWidget {
  const CurrenciesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Supported Currencies')),
      body: BlocBuilder<CurrenciesBloc, CurrenciesState>(
        builder: (context, state) {
          if (state is CurrenciesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CurrenciesLoaded) {
            return ListView.builder(
              itemCount: state.currencies.length,
              itemBuilder: (context, index) {
                final currency = state.currencies[index];
                return ListTile(
                  title: Text(currency.name),
                  subtitle: Text(currency.code),
                );
              },
            );
          }

          if (state is CurrenciesError) {
            return Center(child: Text(state.message));
          }

          return Center(
            child: ElevatedButton(
              onPressed: () {
                context
                    .read<CurrenciesBloc>()
                    .add(LoadCurrenciesEvent());
              },
              child: const Text('Load Currencies'),
            ),
          );
        },
      ),
    );
  }
}
