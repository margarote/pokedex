import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/src/core/errors/exceptions.dart';
import 'package:pokedex/src/features/pokemon/presentation/cubit/pokemon_detail_cubit.dart';
import 'package:pokedex/src/features/pokemon/presentation/cubit/pokemon_detail_state.dart';

import '../../../../../fixtures/pokemon_fixtures.dart';
import '../../../../../mocks/mocks.dart';

void main() {
  late PokemonDetailCubit cubit;
  late MockGetPokemonById mockGetPokemonById;

  setUp(() {
    mockGetPokemonById = MockGetPokemonById();
    cubit = PokemonDetailCubit(getPokemonById: mockGetPokemonById);
  });

  tearDown(() => cubit.close());

  group('PokemonDetailCubit', () {
    test('initial state is correct', () {
      expect(cubit.state, const PokemonDetailState());
    });

    blocTest<PokemonDetailCubit, PokemonDetailState>(
      'emits loading,success when succeeds',
      build: () {
        when(() => mockGetPokemonById(1))
            .thenAnswer((_) async => PokemonFixtures.bulbasaur);
        return cubit;
      },
      act: (cubit) => cubit.loadPokemon(1),
      expect: () => [
        const PokemonDetailState(status: PokemonDetailStatus.loading),
        const PokemonDetailState(
          status: PokemonDetailStatus.success,
          pokemon: PokemonFixtures.bulbasaur,
        ),
      ],
    );

    blocTest<PokemonDetailCubit, PokemonDetailState>(
      'emits loading,failure on NotFoundException',
      build: () {
        when(() => mockGetPokemonById(1022))
            .thenThrow(const NotFoundException());
        return cubit;
      },
      act: (cubit) => cubit.loadPokemon(1022),
      expect: () => [
        const PokemonDetailState(status: PokemonDetailStatus.loading),
        const PokemonDetailState(
          status: PokemonDetailStatus.failure,
          errorMessage: 'Pokemon não encontrado',
        ),
      ],
    );

    blocTest<PokemonDetailCubit, PokemonDetailState>(
      'emits loading,failure on NetworkException',
      build: () {
        when(() => mockGetPokemonById(1)).thenThrow(const NetworkException());
        return cubit;
      },
      act: (cubit) => cubit.loadPokemon(1),
      expect: () => [
        const PokemonDetailState(status: PokemonDetailStatus.loading),
        const PokemonDetailState(
          status: PokemonDetailStatus.failure,
          errorMessage: 'Sem conexão com a internet',
        ),
      ],
    );
  });
}
