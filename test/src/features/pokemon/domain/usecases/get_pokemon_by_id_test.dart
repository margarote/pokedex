import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/src/features/pokemon/domain/usecases/get_pokemon_by_id.dart';

import '../../../../../fixtures/pokemon_fixtures.dart';
import '../../../../../mocks/mocks.dart';

void main() {
  late GetPokemonById usecase;
  late MockPokemonRepository mockRepository;

  setUp(() {
    mockRepository = MockPokemonRepository();
    usecase = GetPokemonById(mockRepository);
  });

  test('returns pokemon by id from repository', () async {
    when(() => mockRepository.getPokemonById(1))
        .thenAnswer((_) async => PokemonFixtures.bulbasaur);

    final result = await usecase(1);

    expect(result, PokemonFixtures.bulbasaur);
    verify(() => mockRepository.getPokemonById(1)).called(1);
  });
}
