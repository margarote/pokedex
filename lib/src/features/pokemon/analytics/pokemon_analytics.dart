import '../../../injection_container.dart';

abstract class PokemonAnalytics {
  static const _screenHome = 'home';
  static const _screenDetail = 'pokemon_detail';

  static const _eventPokemonSelected = 'pokemon_selected';
  static const _eventSearchPerformed = 'search_performed';

  static const _paramPokemonId = 'pokemon_id';
  static const _paramPokemonName = 'pokemon_name';
  static const _paramSearchQuery = 'search_query';

  static void logHomeScreen() =>
      injector.analytics.logScreenView(_screenHome);

  static void logDetailScreen() =>
      injector.analytics.logScreenView(_screenDetail);

  static void logPokemonSelected(int id, String name) {
    injector.analytics.logEvent(_eventPokemonSelected, {
      _paramPokemonId: id,
      _paramPokemonName: name,
    });
  }

  static void logSearch(String query) {
    if (query.isEmpty) return;
    injector.analytics.logEvent(_eventSearchPerformed, {
      _paramSearchQuery: query,
    });
  }
}
