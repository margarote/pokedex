import '../models/pokemon_model.dart';

abstract class PokemonLocalDatasource {
  List<PokemonModel>? getPokemons();
  void savePokemons(List<PokemonModel> pokemons);
  void clear();
}

class PokemonMemoryDatasource implements PokemonLocalDatasource {
  List<PokemonModel>? _cache;

  @override
  List<PokemonModel>? getPokemons() => _cache;

  @override
  void savePokemons(List<PokemonModel> pokemons) => _cache = pokemons;

  @override
  void clear() => _cache = null;
}
