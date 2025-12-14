import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/src/features/pokemon/data/repositories/pokemon_repository_impl.dart';

import '../../../../../fixtures/pokemon_fixtures.dart';
import '../../../../../mocks/mocks.dart';

void main() {
  late PokemonRepositoryImpl repository;
  late MockPokemonDatasource mockRemoteDatasource;
  late MockPokemonLocalDatasource mockLocalDatasource;

  setUp(() {
    mockRemoteDatasource = MockPokemonDatasource();
    mockLocalDatasource = MockPokemonLocalDatasource();
    repository = PokemonRepositoryImpl(
      mockRemoteDatasource,
      mockLocalDatasource,
    );
  });

  group('getPokemons', () {
    test('returns cached data when available', () async {
      when(
        () => mockLocalDatasource.getPokemons(),
      ).thenReturn(PokemonFixtures.pokemonModelList);

      final result = await repository.getPokemons();

      expect(result, PokemonFixtures.pokemonModelList);
      verify(() => mockLocalDatasource.getPokemons()).called(1);
      verifyNever(() => mockRemoteDatasource.getPokemons());
    });

    test('fetches from remote and caches when no cached data', () async {
      when(() => mockLocalDatasource.getPokemons()).thenReturn(null);
      when(
        () => mockRemoteDatasource.getPokemons(),
      ).thenAnswer((_) async => PokemonFixtures.pokemonModelList);
      when(() => mockLocalDatasource.savePokemons(any())).thenReturn(null);

      final result = await repository.getPokemons();

      expect(result, PokemonFixtures.pokemonModelList);
      verify(() => mockLocalDatasource.getPokemons()).called(1);
      verify(() => mockRemoteDatasource.getPokemons()).called(1);
      verify(
        () =>
            mockLocalDatasource.savePokemons(PokemonFixtures.pokemonModelList),
      ).called(1);
    });
  });

  group('getPokemonById', () {
    test('returns pokemon when found', () async {
      when(
        () => mockLocalDatasource.getPokemons(),
      ).thenReturn(PokemonFixtures.pokemonModelList);

      final result = await repository.getPokemonById(1);

      expect(result, PokemonFixtures.bulbasaurModel);
    });

    test('throws StateError when pokemon not found', () async {
      when(
        () => mockLocalDatasource.getPokemons(),
      ).thenReturn(PokemonFixtures.pokemonModelList);

      expect(() => repository.getPokemonById(999), throwsA(isA<StateError>()));
    });
  });

  group('searchPokemons', () {
    test('returns all pokemons when query is empty', () async {
      when(
        () => mockLocalDatasource.getPokemons(),
      ).thenReturn(PokemonFixtures.pokemonModelList);

      final result = await repository.searchPokemons('');

      expect(result, PokemonFixtures.pokemonModelList);
    });

    test('filters pokemons by name', () async {
      when(
        () => mockLocalDatasource.getPokemons(),
      ).thenReturn(PokemonFixtures.pokemonModelList);

      final result = await repository.searchPokemons('bulba');

      expect(result.length, 1);
      expect(result.first.name, 'Bulbasaur');
    });

    test('filters pokemons by id', () async {
      when(
        () => mockLocalDatasource.getPokemons(),
      ).thenReturn(PokemonFixtures.pokemonModelList);

      final result = await repository.searchPokemons('4');

      expect(result.length, 1);
      expect(result.first.name, 'Charmander');
    });

    test('returns empty list when no match', () async {
      when(
        () => mockLocalDatasource.getPokemons(),
      ).thenReturn(PokemonFixtures.pokemonModelList);

      final result = await repository.searchPokemons('pikachu');

      expect(result, isEmpty);
    });

    test('search is case insensitive', () async {
      when(
        () => mockLocalDatasource.getPokemons(),
      ).thenReturn(PokemonFixtures.pokemonModelList);

      final result = await repository.searchPokemons('BULBA');

      expect(result.length, 1);
      expect(result.first.name, 'Bulbasaur');
    });
  });
}
