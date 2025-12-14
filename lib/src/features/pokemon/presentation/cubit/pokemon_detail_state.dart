import 'package:equatable/equatable.dart';

import '../../domain/entities/pokemon_entity.dart';

enum PokemonDetailStatus { initial, loading, success, failure }

class PokemonDetailState extends Equatable {
  final PokemonDetailStatus status;
  final PokemonEntity? pokemon;
  final String? errorMessage;

  const PokemonDetailState({
    this.status = PokemonDetailStatus.initial,
    this.pokemon,
    this.errorMessage,
  });

  PokemonDetailState copyWith({
    PokemonDetailStatus? status,
    PokemonEntity? pokemon,
    String? errorMessage,
  }) {
    return PokemonDetailState(
      status: status ?? this.status,
      pokemon: pokemon ?? this.pokemon,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, pokemon, errorMessage];
}
