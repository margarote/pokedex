import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/src/features/pokemon/domain/usecases/get_pokemons.dart';

import '../../../../../fixtures/pokemon_fixtures.dart';
import '../../../../../mocks/mocks.dart';

void main() {
  late GetPokemons usecase;
  late MockPokemonRepository mockRepository;

  setUp(() {
    mockRepository = MockPokemonRepository();
    usecase = GetPokemons(mockRepository);
  });

  test('returns list of pokemons from repository', () async {
    when(() => mockRepository.getPokemons())
        .thenAnswer((_) async => PokemonFixtures.pokemonList);

    final result = await usecase();

    expect(result, PokemonFixtures.pokemonList);
    verify(() => mockRepository.getPokemons()).called(1);
  });
}
