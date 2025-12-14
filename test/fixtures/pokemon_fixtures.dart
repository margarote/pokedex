import 'package:pokedex/src/features/pokemon/data/models/pokemon_model.dart';
import 'package:pokedex/src/features/pokemon/domain/entities/pokemon_entity.dart';

abstract class PokemonFixtures {
  static const bulbasaur = PokemonEntity(
    id: 1,
    number: '001',
    name: 'Bulbasaur',
    img: 'http://example.com/001.png',
    type: ['Grass', 'Poison'],
    height: '0.71 m',
    weight: '6.9 kg',
    candy: 'Bulbasaur Candy',
    candyCount: 25,
    egg: '2 km',
    spawnChance: 0.69,
    avgSpawns: 69,
    spawnTime: '20:00',
    multipliers: [1.58],
    weaknesses: ['Fire', 'Ice', 'Flying', 'Psychic'],
    nextEvolution: [
      PokemonEvolution(number: '002', name: 'Ivysaur'),
    ],
  );

  static const charmander = PokemonEntity(
    id: 4,
    number: '004',
    name: 'Charmander',
    img: 'http://example.com/004.png',
    type: ['Fire'],
    height: '0.61 m',
    weight: '8.5 kg',
    candy: 'Charmander Candy',
    candyCount: 25,
    egg: '2 km',
    spawnChance: 0.253,
    avgSpawns: 25.3,
    spawnTime: '08:45',
    multipliers: [1.65],
    weaknesses: ['Water', 'Ground', 'Rock'],
  );

  static const pokemonList = [bulbasaur, charmander];

  static const pokemonJson = {
    'pokemon': [
      {
        'id': 1,
        'num': '001',
        'name': 'Bulbasaur',
        'img': 'http://example.com/001.png',
        'type': ['Grass', 'Poison'],
        'height': '0.71 m',
        'weight': '6.9 kg',
        'candy': 'Bulbasaur Candy',
        'candy_count': 25,
        'egg': '2 km',
        'spawn_chance': 0.69,
        'avg_spawns': 69,
        'spawn_time': '20:00',
        'multipliers': [1.58],
        'weaknesses': ['Fire', 'Ice', 'Flying', 'Psychic'],
        'next_evolution': [
          {'num': '002', 'name': 'Ivysaur'},
        ],
      },
    ],
  };

  static const bulbasaurModel = PokemonModel(
    id: 1,
    number: '001',
    name: 'Bulbasaur',
    img: 'http://example.com/001.png',
    type: ['Grass', 'Poison'],
    height: '0.71 m',
    weight: '6.9 kg',
    candy: 'Bulbasaur Candy',
    candyCount: 25,
    egg: '2 km',
    spawnChance: 0.69,
    avgSpawns: 69,
    spawnTime: '20:00',
    multipliers: [1.58],
    weaknesses: ['Fire', 'Ice', 'Flying', 'Psychic'],
    nextEvolution: [
      PokemonEvolutionModel(number: '002', name: 'Ivysaur'),
    ],
  );

  static const charmanderModel = PokemonModel(
    id: 4,
    number: '004',
    name: 'Charmander',
    img: 'http://example.com/004.png',
    type: ['Fire'],
    height: '0.61 m',
    weight: '8.5 kg',
    candy: 'Charmander Candy',
    candyCount: 25,
    egg: '2 km',
    spawnChance: 0.253,
    avgSpawns: 25.3,
    spawnTime: '08:45',
    multipliers: [1.65],
    weaknesses: ['Water', 'Ground', 'Rock'],
  );

  static const pokemonModelList = [bulbasaurModel, charmanderModel];
}
