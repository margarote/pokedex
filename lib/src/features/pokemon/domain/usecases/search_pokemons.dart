import '../entities/pokemon_entity.dart';
import '../repositories/pokemon_repository.dart';

class SearchPokemons {
  final PokemonRepository _repository;

  SearchPokemons(this._repository);

  Future<List<PokemonEntity>> call(String query) async {
    return _repository.searchPokemons(query);
  }
}
