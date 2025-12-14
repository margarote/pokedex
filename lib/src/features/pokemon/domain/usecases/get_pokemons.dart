import '../entities/pokemon_entity.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemons {
  final PokemonRepository _repository;
  GetPokemons(this._repository);

  Future<List<PokemonEntity>> call() async {
    return _repository.getPokemons();
  }
}
