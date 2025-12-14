import 'package:equatable/equatable.dart';

class PokemonEntity extends Equatable {
  final int id;
  final String number;
  final String name;
  final String img;
  final List<String> type;
  final String height;
  final String weight;
  final String candy;
  final int? candyCount;
  final String egg;
  final double spawnChance;
  final double avgSpawns;
  final String spawnTime;
  final List<double>? multipliers;
  final List<String> weaknesses;
  final List<PokemonEvolution>? nextEvolution;
  final List<PokemonEvolution>? prevEvolution;

  const PokemonEntity({
    required this.id,
    required this.number,
    required this.name,
    required this.img,
    required this.type,
    required this.height,
    required this.weight,
    required this.candy,
    this.candyCount,
    required this.egg,
    required this.spawnChance,
    required this.avgSpawns,
    required this.spawnTime,
    this.multipliers,
    required this.weaknesses,
    this.nextEvolution,
    this.prevEvolution,
  });

  @override
  List<Object?> get props => [
        id,
        number,
        name,
        img,
        type,
        height,
        weight,
        candy,
        candyCount,
        egg,
        spawnChance,
        avgSpawns,
        spawnTime,
        multipliers,
        weaknesses,
        nextEvolution,
        prevEvolution,
      ];
}

class PokemonEvolution extends Equatable {
  final String number;
  final String name;

  const PokemonEvolution({
    required this.number,
    required this.name,
  });

  @override
  List<Object?> get props => [number, name];
}
