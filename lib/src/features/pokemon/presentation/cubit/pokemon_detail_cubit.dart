import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../../domain/usecases/get_pokemon_by_id.dart';
import 'pokemon_detail_state.dart';

class PokemonDetailCubit extends Cubit<PokemonDetailState> {
  final GetPokemonById _getPokemonById;

  PokemonDetailCubit({
    required GetPokemonById getPokemonById,
  })  : _getPokemonById = getPokemonById,
        super(const PokemonDetailState());

  Future<void> loadPokemon(int id) async {
    _emitLoading();

    try {
      final pokemon = await _getPokemonById(id);
      _emitSuccess(pokemon);
    } on AppException catch (e) {
      _emitFailure(e.message);
    }
  }

  void _emitLoading() {
    emit(state.copyWith(status: PokemonDetailStatus.loading));
  }

  void _emitSuccess(PokemonEntity pokemon) {
    emit(state.copyWith(
      status: PokemonDetailStatus.success,
      pokemon: pokemon,
    ));
  }

  void _emitFailure(String message) {
    emit(state.copyWith(
      status: PokemonDetailStatus.failure,
      errorMessage: message,
    ));
  }
}
