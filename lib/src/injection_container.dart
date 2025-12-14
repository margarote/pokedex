import 'core/analytics/analytics_service.dart';
import 'core/analytics/google_analytics_service.dart';
import 'core/network/dio_client.dart';
import 'features/pokemon/data/datasources/pokemon_dio_datasource.dart';
import 'features/pokemon/data/datasources/pokemon_local_datasource.dart';
import 'features/pokemon/data/repositories/pokemon_repository_impl.dart';
import 'features/pokemon/domain/usecases/get_pokemon_by_id.dart';
import 'features/pokemon/domain/usecases/get_pokemons.dart';
import 'features/pokemon/domain/usecases/search_pokemons.dart';
import 'features/pokemon/presentation/cubit/pokemon_detail_cubit.dart';
import 'features/pokemon/presentation/cubit/pokemon_list_cubit.dart';

class InjectionContainer {
  static final InjectionContainer _instance = InjectionContainer._internal();
  factory InjectionContainer() => _instance;
  InjectionContainer._internal();

  late final AnalyticsService _analyticsService;
  late final PokemonDatasource _remoteDatasource;
  late final PokemonLocalDatasource _localDatasource;
  late final PokemonRepositoryImpl _repository;
  late final GetPokemons _getPokemonsUsecase;
  late final GetPokemonById _getPokemonByIdUsecase;
  late final SearchPokemons _searchPokemonsUsecase;

  void init() {
    _analyticsService = GoogleAnalyticsService();

    final dio = DioClient().dio;
    _remoteDatasource = PokemonDioDatasource(dio);
    _localDatasource = PokemonMemoryDatasource();
    _repository = PokemonRepositoryImpl(_remoteDatasource, _localDatasource);
    _getPokemonsUsecase = GetPokemons(_repository);
    _getPokemonByIdUsecase = GetPokemonById(_repository);
    _searchPokemonsUsecase = SearchPokemons(_repository);
  }

  AnalyticsService get analytics => _analyticsService;

  PokemonListCubit get pokemonListCubit => PokemonListCubit(
        getPokemons: _getPokemonsUsecase,
        searchPokemons: _searchPokemonsUsecase,
      );

  PokemonDetailCubit get pokemonDetailCubit => PokemonDetailCubit(
        getPokemonById: _getPokemonByIdUsecase,
      );
}

final injector = InjectionContainer();
