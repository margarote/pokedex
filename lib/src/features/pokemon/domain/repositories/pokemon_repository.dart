import '../entities/pokemon_entity.dart';

abstract class PokemonRepository {
  Future<List<PokemonEntity>> getPokemons();
  Future<PokemonEntity> getPokemonById(int id);
  Future<List<PokemonEntity>> searchPokemons(String query);
}
