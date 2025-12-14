import 'package:equatable/equatable.dart';

import '../../domain/entities/pokemon_entity.dart';

enum PokemonListStatus { initial, loading, success, failure }

enum PokemonSortType { alphabetical, byId }

class PokemonListState extends Equatable {
  final PokemonListStatus status;
  final List<PokemonEntity> pokemons;
  final List<PokemonEntity> filteredPokemons;
  final String searchQuery;
  final String? errorMessage;
  final PokemonSortType sortType;

  const PokemonListState({
    this.status = PokemonListStatus.initial,
    this.pokemons = const [],
    this.filteredPokemons = const [],
    this.searchQuery = '',
    this.errorMessage,
    this.sortType = PokemonSortType.byId,
  });

  PokemonListState copyWith({
    PokemonListStatus? status,
    List<PokemonEntity>? pokemons,
    List<PokemonEntity>? filteredPokemons,
    String? searchQuery,
    String? errorMessage,
    PokemonSortType? sortType,
  }) {
    return PokemonListState(
      status: status ?? this.status,
      pokemons: pokemons ?? this.pokemons,
      filteredPokemons: filteredPokemons ?? this.filteredPokemons,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage ?? this.errorMessage,
      sortType: sortType ?? this.sortType,
    );
  }

  @override
  List<Object?> get props => [
        status,
        pokemons,
        filteredPokemons,
        searchQuery,
        errorMessage,
        sortType,
      ];
}
