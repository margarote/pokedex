import 'package:get_it/get_it.dart';

import 'core/analytics/analytics_service.dart';
import 'core/analytics/google_analytics_service.dart';
import 'core/network/dio_client.dart';
import 'features/pokemon/data/datasources/pokemon_dio_datasource.dart';
import 'features/pokemon/data/datasources/pokemon_local_datasource.dart';
import 'features/pokemon/data/repositories/pokemon_repository_impl.dart';
import 'features/pokemon/domain/repositories/pokemon_repository.dart';
import 'features/pokemon/domain/usecases/get_pokemon_by_id.dart';
import 'features/pokemon/domain/usecases/get_pokemons.dart';
import 'features/pokemon/domain/usecases/search_pokemons.dart';
import 'features/pokemon/presentation/cubit/pokemon_detail_cubit.dart';
import 'features/pokemon/presentation/cubit/pokemon_list_cubit.dart';

final sl = GetIt.instance;

void setupDependencies() {
  // Core
  sl.registerLazySingleton<AnalyticsService>(() => GoogleAnalyticsService());
  sl.registerLazySingleton(() => DioClient().dio);

  // Datasources
  sl.registerLazySingleton<PokemonDatasource>(
    () => PokemonDioDatasource(sl()),
  );
  sl.registerLazySingleton<PokemonLocalDatasource>(
    () => PokemonMemoryDatasource(),
  );

  // Repository
  sl.registerLazySingleton<PokemonRepository>(
    () => PokemonRepositoryImpl(sl(), sl()),
  );

  // Usecases
  sl.registerLazySingleton(() => GetPokemons(sl()));
  sl.registerLazySingleton(() => GetPokemonById(sl()));
  sl.registerLazySingleton(() => SearchPokemons(sl()));

  // Cubits
  sl.registerFactory(
    () => PokemonListCubit(
      getPokemons: sl(),
      searchPokemons: sl(),
    ),
  );
  sl.registerFactory(
    () => PokemonDetailCubit(
      getPokemonById: sl(),
    ),
  );
}
