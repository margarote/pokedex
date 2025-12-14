import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/src/core/constants/api_constants.dart';
import 'package:pokedex/src/core/errors/exceptions.dart';
import 'package:pokedex/src/features/pokemon/data/datasources/pokemon_dio_datasource.dart';
import 'package:pokedex/src/features/pokemon/data/models/pokemon_model.dart';

import '../../../../../fixtures/pokemon_fixtures.dart';
import '../../../../../mocks/mocks.dart';

void main() {
  late PokemonDioDatasource datasource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    datasource = PokemonDioDatasource(mockDio);
  });

  group('getPokemons', () {
    test('returns list of PokemonModel when status is 200', () async {
      when(() => mockDio.get(ApiConstants.pokedexEndpoint)).thenAnswer(
        (_) async => Response(
          data: PokemonFixtures.pokemonJson,
          statusCode: 200,
          requestOptions: RequestOptions(),
        ),
      );

      final result = await datasource.getPokemons();

      expect(result, isA<List<PokemonModel>>());
      expect(result.first.name, PokemonFixtures.bulbasaur.name);
    });

    test('throws ServerException when status is not 200', () async {
      when(() => mockDio.get(ApiConstants.pokedexEndpoint)).thenAnswer(
        (_) async => Response(
          data: null,
          statusCode: 500,
          requestOptions: RequestOptions(),
        ),
      );

      expect(() => datasource.getPokemons(), throwsA(isA<ServerException>()));
    });

    test('throws NetworkException on connection error', () async {
      when(() => mockDio.get(ApiConstants.pokedexEndpoint)).thenThrow(
        DioException(
          type: DioExceptionType.connectionError,
          requestOptions: RequestOptions(),
        ),
      );

      expect(() => datasource.getPokemons(), throwsA(isA<NetworkException>()));
    });

    test('throws ServerException on DioException', () async {
      when(() => mockDio.get(ApiConstants.pokedexEndpoint)).thenThrow(
        DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(),
        ),
      );

      expect(() => datasource.getPokemons(), throwsA(isA<ServerException>()));
    });
  });
}
