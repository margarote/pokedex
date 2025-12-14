import '../../domain/entities/pokemon_entity.dart';

class PokemonModel extends PokemonEntity {
  const PokemonModel({
    required super.id,
    required super.number,
    required super.name,
    required super.img,
    required super.type,
    required super.height,
    required super.weight,
    required super.candy,
    super.candyCount,
    required super.egg,
    required super.spawnChance,
    required super.avgSpawns,
    required super.spawnTime,
    super.multipliers,
    required super.weaknesses,
    super.nextEvolution,
    super.prevEvolution,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      id: json['id'] as int,
      number: json['num'] as String,
      name: json['name'] as String,
      img: json['img'] as String,
      type: List<String>.from(json['type'] as List),
      height: json['height'] as String,
      weight: json['weight'] as String,
      candy: json['candy'] as String? ?? '',
      candyCount: json['candy_count'] as int?,
      egg: json['egg'] as String,
      spawnChance: (json['spawn_chance'] as num).toDouble(),
      avgSpawns: (json['avg_spawns'] as num).toDouble(),
      spawnTime: json['spawn_time'] as String,
      multipliers: json['multipliers'] != null
          ? List<double>.from(
              (json['multipliers'] as List).map((e) => (e as num).toDouble()),
            )
          : null,
      weaknesses: List<String>.from(json['weaknesses'] as List),
      nextEvolution: json['next_evolution'] != null
          ? List<PokemonEvolutionModel>.from(
              (json['next_evolution'] as List)
                  .map((e) => PokemonEvolutionModel.fromJson(e)),
            )
          : null,
      prevEvolution: json['prev_evolution'] != null
          ? List<PokemonEvolutionModel>.from(
              (json['prev_evolution'] as List)
                  .map((e) => PokemonEvolutionModel.fromJson(e)),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'num': number,
      'name': name,
      'img': img,
      'type': type,
      'height': height,
      'weight': weight,
      'candy': candy,
      'candy_count': candyCount,
      'egg': egg,
      'spawn_chance': spawnChance,
      'avg_spawns': avgSpawns,
      'spawn_time': spawnTime,
      'multipliers': multipliers,
      'weaknesses': weaknesses,
      'next_evolution': nextEvolution
          ?.map((e) => {'num': e.number, 'name': e.name})
          .toList(),
      'prev_evolution': prevEvolution
          ?.map((e) => {'num': e.number, 'name': e.name})
          .toList(),
    };
  }
}

class PokemonEvolutionModel extends PokemonEvolution {
  const PokemonEvolutionModel({
    required super.number,
    required super.name,
  });

  factory PokemonEvolutionModel.fromJson(Map<String, dynamic> json) {
    return PokemonEvolutionModel(
      number: json['num'] as String,
      name: json['name'] as String,
    );
  }
}
