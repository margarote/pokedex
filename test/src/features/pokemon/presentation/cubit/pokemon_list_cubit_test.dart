import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/src/core/errors/exceptions.dart';
import 'package:pokedex/src/features/pokemon/presentation/cubit/pokemon_list_cubit.dart';
import 'package:pokedex/src/features/pokemon/presentation/cubit/pokemon_list_state.dart';

import '../../../../../fixtures/pokemon_fixtures.dart';
import '../../../../../mocks/mocks.dart';

void main() {
  late PokemonListCubit cubit;
  late MockGetPokemons mockGetPokemons;
  late MockSearchPokemons mockSearchPokemons;

  setUp(() {
    mockGetPokemons = MockGetPokemons();
    mockSearchPokemons = MockSearchPokemons();
    cubit = PokemonListCubit(
      getPokemons: mockGetPokemons,
      searchPokemons: mockSearchPokemons,
    );
  });

  tearDown(() => cubit.close());

  group('PokemonListCubit', () {
    test('initial state is correct', () {
      expect(cubit.state, const PokemonListState());
    });

    group('loadPokemons', () {
      blocTest<PokemonListCubit, PokemonListState>(
        'emits loading, success when succeeds',
        build: () {
          when(() => mockGetPokemons())
              .thenAnswer((_) async => PokemonFixtures.pokemonList);
          return cubit;
        },
        act: (cubit) => cubit.loadPokemons(),
        expect: () => [
          const PokemonListState(status: PokemonListStatus.loading),
          const PokemonListState(
            status: PokemonListStatus.success,
            pokemons: PokemonFixtures.pokemonList,
            filteredPokemons: PokemonFixtures.pokemonList,
          ),
        ],
      );

      blocTest<PokemonListCubit, PokemonListState>(
        'emits loading,failure on ServerException',
        build: () {
          when(() => mockGetPokemons()).thenThrow(const ServerException());
          return cubit;
        },
        act: (cubit) => cubit.loadPokemons(),
        expect: () => [
          const PokemonListState(status: PokemonListStatus.loading),
          const PokemonListState(
            status: PokemonListStatus.failure,
            errorMessage: 'Erro no servidor',
          ),
        ],
      );

      blocTest<PokemonListCubit, PokemonListState>(
        'emits loading,failure on NetworkException',
        build: () {
          when(() => mockGetPokemons()).thenThrow(const NetworkException());
          return cubit;
        },
        act: (cubit) => cubit.loadPokemons(),
        expect: () => [
          const PokemonListState(status: PokemonListStatus.loading),
          const PokemonListState(
            status: PokemonListStatus.failure,
            errorMessage: 'Sem conexão com a internet',
          ),
        ],
      );
    });

    group('searchPokemons', () {
      blocTest<PokemonListCubit, PokemonListState>(
        'filters pokemons when query is not empty',
        build: () {
          when(() => mockSearchPokemons('bulba'))
              .thenAnswer((_) async => [PokemonFixtures.bulbasaur]);
          return cubit;
        },
        seed: () => const PokemonListState(
          status: PokemonListStatus.success,
          pokemons: PokemonFixtures.pokemonList,
          filteredPokemons: PokemonFixtures.pokemonList,
        ),
        act: (cubit) => cubit.searchPokemons('bulba'),
        verify: (cubit) {
          expect(cubit.state.searchQuery, 'bulba');
          expect(cubit.state.filteredPokemons, [PokemonFixtures.bulbasaur]);
        },
      );

      blocTest<PokemonListCubit, PokemonListState>(
        'returns all pokemons when query is empty',
        build: () => cubit,
        seed: () => const PokemonListState(
          status: PokemonListStatus.success,
          pokemons: PokemonFixtures.pokemonList,
          filteredPokemons: [],
          searchQuery: 'bulba',
        ),
        act: (cubit) => cubit.searchPokemons(''),
        verify: (cubit) {
          expect(cubit.state.searchQuery, '');
          expect(cubit.state.filteredPokemons, PokemonFixtures.pokemonList);
        },
      );
    });
  });
}
