import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/src/features/pokemon/data/models/pokemon_model.dart';

void main() {
  group('PokemonModel', () {
    const json = {
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
      'prev_evolution': [
        {'num': '000', 'name': 'Seed'},
      ],
    };

    test('fromJson creates model correctly', () {
      final model = PokemonModel.fromJson(json);

      expect(model.id, 1);
      expect(model.number, '001');
      expect(model.name, 'Bulbasaur');
      expect(model.img, 'http://example.com/001.png');
      expect(model.type, ['Grass', 'Poison']);
      expect(model.height, '0.71 m');
      expect(model.weight, '6.9 kg');
      expect(model.candy, 'Bulbasaur Candy');
      expect(model.candyCount, 25);
      expect(model.egg, '2 km');
      expect(model.spawnChance, 0.69);
      expect(model.avgSpawns, 69);
      expect(model.spawnTime, '20:00');
      expect(model.multipliers, [1.58]);
      expect(model.weaknesses, ['Fire', 'Ice', 'Flying', 'Psychic']);
      expect(model.nextEvolution?.length, 1);
      expect(model.nextEvolution?.first.name, 'Ivysaur');
      expect(model.prevEvolution?.length, 1);
      expect(model.prevEvolution?.first.name, 'Seed');
    });

    test('fromJson handles null candy', () {
      final jsonWithoutCandy = Map<String, dynamic>.from(json);
      jsonWithoutCandy['candy'] = null;

      final model = PokemonModel.fromJson(jsonWithoutCandy);

      expect(model.candy, '');
    });

    test('fromJson handles null multipliers', () {
      final jsonWithoutMultipliers = Map<String, dynamic>.from(json);
      jsonWithoutMultipliers['multipliers'] = null;

      final model = PokemonModel.fromJson(jsonWithoutMultipliers);

      expect(model.multipliers, isNull);
    });

    test('fromJson handles null evolutions', () {
      final jsonWithoutEvolutions = Map<String, dynamic>.from(json);
      jsonWithoutEvolutions['next_evolution'] = null;
      jsonWithoutEvolutions['prev_evolution'] = null;

      final model = PokemonModel.fromJson(jsonWithoutEvolutions);

      expect(model.nextEvolution, isNull);
      expect(model.prevEvolution, isNull);
    });

    test('toJson converts model correctly', () {
      final model = PokemonModel.fromJson(json);
      final result = model.toJson();

      expect(result['id'], 1);
      expect(result['num'], '001');
      expect(result['name'], 'Bulbasaur');
      expect(result['img'], 'http://example.com/001.png');
      expect(result['type'], ['Grass', 'Poison']);
      expect(result['height'], '0.71 m');
      expect(result['weight'], '6.9 kg');
      expect(result['candy'], 'Bulbasaur Candy');
      expect(result['candy_count'], 25);
      expect(result['egg'], '2 km');
      expect(result['spawn_chance'], 0.69);
      expect(result['avg_spawns'], 69);
      expect(result['spawn_time'], '20:00');
      expect(result['multipliers'], [1.58]);
      expect(result['weaknesses'], ['Fire', 'Ice', 'Flying', 'Psychic']);
      expect(result['next_evolution'], [{'num': '002', 'name': 'Ivysaur'}]);
      expect(result['prev_evolution'], [{'num': '000', 'name': 'Seed'}]);
    });

    test('toJson handles null evolutions', () {
      final jsonWithoutEvolutions = Map<String, dynamic>.from(json);
      jsonWithoutEvolutions['next_evolution'] = null;
      jsonWithoutEvolutions['prev_evolution'] = null;

      final model = PokemonModel.fromJson(jsonWithoutEvolutions);
      final result = model.toJson();

      expect(result['next_evolution'], isNull);
      expect(result['prev_evolution'], isNull);
    });
  });

  group('PokemonEvolutionModel', () {
    test('fromJson creates model correctly', () {
      final json = {'num': '002', 'name': 'Ivysaur'};

      final model = PokemonEvolutionModel.fromJson(json);

      expect(model.number, '002');
      expect(model.name, 'Ivysaur');
    });
  });
}
