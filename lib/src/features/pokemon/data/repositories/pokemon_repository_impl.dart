import '../../domain/entities/pokemon_entity.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../datasources/pokemon_dio_datasource.dart';
import '../datasources/pokemon_local_datasource.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonDatasource _remoteDatasource;
  final PokemonLocalDatasource _localDatasource;

  PokemonRepositoryImpl(this._remoteDatasource, this._localDatasource);

  @override
  Future<List<PokemonEntity>> getPokemons() async {
    final cached = _localDatasource.getPokemons();
    if (cached != null) return cached;

    final pokemons = await _remoteDatasource.getPokemons();
    _localDatasource.savePokemons(pokemons);

    return pokemons;
  }

  @override
  Future<PokemonEntity> getPokemonById(int id) async {
    final pokemons = await getPokemons();
    return pokemons.firstWhere((p) => p.id == id);
  }

  @override
  Future<List<PokemonEntity>> searchPokemons(String query) async {
    final pokemons = await getPokemons();
    if (query.isEmpty) return pokemons;

    return _filterByNameOrId(pokemons, query);
  }

  List<PokemonEntity> _filterByNameOrId(
    List<PokemonEntity> list,
    String query,
  ) {
    final lowerQuery = query.toLowerCase();

    return list.where((p) => _matches(p, lowerQuery)).toList();
  }

  bool _matches(PokemonEntity pokemon, String query) {
    return pokemon.name.toLowerCase().contains(query) ||
        pokemon.id.toString().contains(query);
  }
}
