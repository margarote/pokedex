import '../entities/pokemon_entity.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemonById {
  final PokemonRepository _repository;

  GetPokemonById(this._repository);

  Future<PokemonEntity> call(int id) async {
    return _repository.getPokemonById(id);
  }
}
