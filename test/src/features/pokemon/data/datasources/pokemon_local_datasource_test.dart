import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/src/features/pokemon/data/datasources/pokemon_local_datasource.dart';

import '../../../../../fixtures/pokemon_fixtures.dart';

void main() {
  late PokemonMemoryDatasource datasource;

  setUp(() {
    datasource = PokemonMemoryDatasource();
  });

  group('PokemonMemoryDatasource', () {
    test('getPokemons returns null when cache is empty', () {
      final result = datasource.getPokemons();

      expect(result, isNull);
    });

    test('savePokemons stores pokemons in cache', () {
      datasource.savePokemons(PokemonFixtures.pokemonModelList);

      final result = datasource.getPokemons();

      expect(result, PokemonFixtures.pokemonModelList);
    });

    test('getPokemons returns cached pokemons', () {
      datasource.savePokemons(PokemonFixtures.pokemonModelList);

      final result = datasource.getPokemons();

      expect(result, PokemonFixtures.pokemonModelList);
      expect(result?.length, 2);
    });

    test('clear removes cached pokemons', () {
      datasource.savePokemons(PokemonFixtures.pokemonModelList);
      expect(datasource.getPokemons(), isNotNull);

      datasource.clear();

      expect(datasource.getPokemons(), isNull);
    });

    test('savePokemons overwrites existing cache', () {
      datasource.savePokemons(PokemonFixtures.pokemonModelList);
      datasource.savePokemons([PokemonFixtures.bulbasaurModel]);

      final result = datasource.getPokemons();

      expect(result?.length, 1);
      expect(result?.first, PokemonFixtures.bulbasaurModel);
    });
  });
}
