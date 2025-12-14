import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../../domain/usecases/get_pokemons.dart';
import '../../domain/usecases/search_pokemons.dart';
import 'pokemon_list_state.dart';

class PokemonListCubit extends Cubit<PokemonListState> {
  final GetPokemons _getPokemons;
  final SearchPokemons _searchPokemons;

  PokemonListCubit({
    required GetPokemons getPokemons,
    required SearchPokemons searchPokemons,
  })  : _getPokemons = getPokemons,
        _searchPokemons = searchPokemons,
        super(const PokemonListState());

  Future<void> loadPokemons() async {
    _emitLoading();

    try {
      final pokemons = await _getPokemons();
      _emitSuccess(pokemons);
    } on AppException catch (e) {
      _emitFailure(e.message);
    }
  }

  Future<void> searchPokemons(String query) async {
    _emitSearchQuery(query);

    if (query.isEmpty) {
      _emitFiltered(_applySorting(state.pokemons, state.sortType));
      return;
    }

    try {
      final filtered = await _searchPokemons(query);
      _emitFiltered(_applySorting(filtered, state.sortType));
    } on AppException catch (e) {
      _emitFailure(e.message);
    }
  }

  void setSortType(PokemonSortType sortType) {
    if (state.sortType == sortType) return;

    final sorted = _applySorting(state.filteredPokemons, sortType);

    emit(state.copyWith(sortType: sortType, filteredPokemons: sorted));
  }

  List<PokemonEntity> _applySorting(
    List<PokemonEntity> pokemons,
    PokemonSortType sortType,
  ) {
    final sorted = List<PokemonEntity>.from(pokemons);

    switch (sortType) {
      case PokemonSortType.alphabetical:
        sorted.sort((a, b) => a.name.compareTo(b.name));
      case PokemonSortType.byId:
        sorted.sort((a, b) => a.id.compareTo(b.id));
    }

    return sorted;
  }

  void _emitLoading() {
    emit(state.copyWith(status: PokemonListStatus.loading));
  }

  void _emitSuccess(List<PokemonEntity> pokemons) {
    final sorted = _applySorting(pokemons, state.sortType);

    emit(state.copyWith(
      status: PokemonListStatus.success,
      pokemons: pokemons,
      filteredPokemons: sorted,
    ));
  }

  void _emitFailure(String message) {
    emit(state.copyWith(
      status: PokemonListStatus.failure,
      errorMessage: message,
    ));
  }

  void _emitSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  void _emitFiltered(List<PokemonEntity> pokemons) {
    emit(state.copyWith(filteredPokemons: pokemons));
  }
}
