import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/src/features/pokemon/domain/usecases/search_pokemons.dart';

import '../../../../../fixtures/pokemon_fixtures.dart';
import '../../../../../mocks/mocks.dart';

void main() {
  late SearchPokemons usecase;
  late MockPokemonRepository mockRepository;

  setUp(() {
    mockRepository = MockPokemonRepository();
    usecase = SearchPokemons(mockRepository);
  });

  test('returns filtered pokemons from repository', () async {
    when(() => mockRepository.searchPokemons('bulba'))
        .thenAnswer((_) async => [PokemonFixtures.bulbasaur]);

    final result = await usecase('bulba');

    expect(result, [PokemonFixtures.bulbasaur]);
    verify(() => mockRepository.searchPokemons('bulba')).called(1);
  });

  test('returns all pokemons when query is empty', () async {
    when(() => mockRepository.searchPokemons(''))
        .thenAnswer((_) async => PokemonFixtures.pokemonList);

    final result = await usecase('');

    expect(result, PokemonFixtures.pokemonList);
    verify(() => mockRepository.searchPokemons('')).called(1);
  });
}
