abstract class AppStrings {
  // Erros
  static const serverError = 'Erro no servidor';
  static const networkError = 'Sem conexão com a internet';
  static const notFoundError = 'Pokemon não encontrado';
  static const errorTitle = 'Ops! Algo deu errado';
  static const errorLoadingPokemons = 'Erro ao carregar pokémons';

  // App
  static const appName = 'Pokedex';
  static const exploreTitle = 'Explore o incrível mundo dos Pokémon.';
  static const exploreSubtitle =
      'Descubra informações detalhadas sobre seus personagens favoritos.';
  static const searchHint = 'Nome ou código do Pokémon';
  static const highlightCount = '+1000k';
  static const highlightLabel = 'Pokémons';

  // Actions
  static const tryAgain = 'Tentar novamente';
  static const filterNotImplemented = 'Filtro ainda não implementado';

  // Filters
  static const sortAlphabetical = 'Alfabética (A-Z)';
  static const sortById = 'Código (crescente)';

  // Empty State
  static const emptyTitle = 'Nenhum Pokémon encontrado';
  static const emptySubtitle = 'Tente buscar por outro nome ou número';

  // List
  static String allPokemonsLoaded(int count) =>
      'Todos os $count Pokémons foram carregados';

  // Pokemon Detail
  static const abilities = 'Habilidades';
  static const baseStats = 'Estatísticas base';
  static const related = 'Relacionados';
  static const height = 'Altura';
  static const weight = 'Peso';
  static const candy = 'Doce';
  static const egg = 'Ovo';
  static const spawnChance = 'Chance de Spawn';
  static const spawnTime = 'Horário de Spawn';
  static const candyCount = 'Qtd. Doces';
}
