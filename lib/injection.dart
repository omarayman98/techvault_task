import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import 'features/currency_history/data/datasources/remote_data_source.dart';
import 'features/currency_history/data/repo/currencies_repo_imp.dart';
import 'features/currency_history/domain/repositories/currency_repo.dart';
import 'features/currency_history/domain/usecases/currency_usecase.dart';
import 'features/currency_history/presentaion/bloc/currency_history_bloc.dart';
import 'features/currency_list/data/datasources/local_data_source.dart';
import 'features/currency_list/data/datasources/remote_data_source.dart';
import 'features/currency_list/data/repo/currencies_repo_imp.dart';
import 'features/currency_list/domain/repositories/currency_repo.dart';
import 'features/currency_list/domain/usecases/currency_usecase.dart';
import 'features/currency_list/presentaion/bloc/currencies_bloc.dart';

final getIt = GetIt.instance;

void setupInjection() {
  // dio
  getIt.registerLazySingleton<Dio>(() => Dio());

  // data source
  getIt.registerLazySingleton<CurrencyRemoteDataSource>(
    () => CurrencyRemoteDataSourceImpl(getIt<Dio>()),
  );

  getIt.registerLazySingleton<CurrencyHistoryRemoteDataSource>(
        () => CurrencyHistoryRemoteDataSourceImpl(getIt<Dio>()),
  );

  getIt.registerLazySingleton<CurrencyLocalDataSource>(
    () => CurrencyLocalDataSourceImpl(),
  );

  // repo
  getIt.registerLazySingleton<CurrencyRepository>(
    () => CurrencyRepositoryImpl(
      getIt<CurrencyRemoteDataSource>(),
      getIt<CurrencyLocalDataSource>(),
    ),
  );
  getIt.registerLazySingleton<CurrencyHistoryRepository>(
        () => CurrencyHistoryRepositoryImpl(getIt<CurrencyHistoryRemoteDataSource>()),
  );

  // use case
  getIt.registerLazySingleton(
    () => GetSupportedCurrencies(getIt<CurrencyRepository>()),
  );
  getIt.registerLazySingleton(
        () => GetCurrencyHistory(getIt<CurrencyHistoryRepository>()),
  );

  //bloc
  getIt.registerFactory(() => CurrenciesBloc(getIt<GetSupportedCurrencies>()));
  getIt.registerFactory(
        () => CurrencyHistoryBloc(getIt<GetCurrencyHistory>()),
  );
}
