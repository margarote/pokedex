abstract class ApiConstants {
  static const String baseUrl =
      'https://raw.githubusercontent.com/Biuni/PokemonGo-Pokedex/master';
  static const String pokedexEndpoint = '/pokedex.json';
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // HTTP Headers
  static const String contentType = 'Content-Type';
  static const String accept = 'Accept';
  static const String applicationJson = 'application/json';

  // JSON Keys
  static const String pokemonJsonKey = 'pokemon';

  // Pokemon Images
  static const String pokemonImageBaseUrl =
      'http://www.serebii.net/pokemongo/pokemon';

  static const String pokeApiImageBaseUrl =
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork';

  static const String homeHeaderPokemonId = '130';

  static String getPokemonImageUrl(String number) =>
      '$pokemonImageBaseUrl/$number.png';

  static String getPokeApiImageUrl(String id) =>
      '$pokeApiImageBaseUrl/$id.png';
}
