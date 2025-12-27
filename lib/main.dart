import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/currency_history/presentaion/bloc/currency_history_bloc.dart';
import 'features/currency_list/data/models/currency_hive_model.dart';
import 'features/currency_list/presentaion/bloc/currencies_bloc.dart';
import 'features/currency_list/presentaion/bloc/currencies_event.dart';
import 'features/currency_list/presentaion/screens/homescreen.dart';
import 'features/currency_list/presentaion/screens/page.dart';
import 'injection.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CurrencyHiveModelAdapter());
  setupInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => getIt<CurrenciesBloc>()..add(LoadCurrenciesEvent()),
          ),
          BlocProvider(create: (_) => getIt<CurrencyHistoryBloc>()),
        ],
        child: CurrencyCombinedPage(),
      ),
    );
  }
}
