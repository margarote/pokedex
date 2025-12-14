import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/src/features/pokemon/data/datasources/pokemon_dio_datasource.dart';
import 'package:pokedex/src/features/pokemon/data/datasources/pokemon_local_datasource.dart';
import 'package:pokedex/src/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/src/features/pokemon/domain/usecases/get_pokemon_by_id.dart';
import 'package:pokedex/src/features/pokemon/domain/usecases/get_pokemons.dart';
import 'package:pokedex/src/features/pokemon/domain/usecases/search_pokemons.dart';

class MockDio extends Mock implements Dio {}

class MockGetPokemons extends Mock implements GetPokemons {}

class MockSearchPokemons extends Mock implements SearchPokemons {}

class MockGetPokemonById extends Mock implements GetPokemonById {}

class MockPokemonDatasource extends Mock implements PokemonDatasource {}

class MockPokemonLocalDatasource extends Mock
    implements PokemonLocalDatasource {}

class MockPokemonRepository extends Mock implements PokemonRepository {}
