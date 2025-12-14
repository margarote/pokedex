import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/pokemon_model.dart';

abstract class PokemonDatasource {
  Future<List<PokemonModel>> getPokemons();
}

class PokemonDioDatasource implements PokemonDatasource {
  final Dio _dio;

  PokemonDioDatasource(this._dio);

  @override
  Future<List<PokemonModel>> getPokemons() async {
    try {
      final response = await _dio.get(ApiConstants.pokedexEndpoint);
      _validateResponse(response);
      return _parsePokemons(response.data);
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  void _validateResponse(Response response) {
    if (response.statusCode != 200) {
      throw const ServerException();
    }
  }

  List<PokemonModel> _parsePokemons(dynamic data) {
    final Map<String, dynamic> map;

    if (data is String) {
      map = json.decode(data) as Map<String, dynamic>;
    } else {
      map = data as Map<String, dynamic>;
    }

    final list = map[ApiConstants.pokemonJsonKey] as List<dynamic>;
    return list
        .map((json) => PokemonModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  AppException _handleDioException(DioException e) {
    final isConnectionError =
        e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout;

    return isConnectionError
        ? const NetworkException()
        : const ServerException();
  }
}
