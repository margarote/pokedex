# Pokedex

App Flutter que consome a PokeAPI para listar e exibir detalhes de Pokémons.

## Versões

- Flutter: 3.38.x
- Dart: 3.10.x

## Como rodar

```bash
# Clonar o projeto
git clone https://github.com/margarote/pokedex.git
cd pokedex

# Instalar dependências
flutter pub get

# Rodar
flutter run
```

## Configuração

Não precisa configurar nada, a PokeAPI é pública e não usa API key.

Se der algum problema, roda `flutter doctor` pra verificar se tá tudo certo com seu ambiente.

## Testes

```bash
flutter test

# Com coverage
flutter test --coverage
```

## Estrutura do Projeto

Usei Clean Architecture pra organizar o código:

```
lib/src/
├── core/           # Coisas compartilhadas (tema, network, erros, etc)
└── features/
    └── pokemon/
        ├── data/           # Models, datasources, implementação dos repos
        ├── domain/         # Entities, usecases, contratos dos repos
        └── presentation/   # Cubits, pages, widgets
```

## Pacotes e por que escolhi cada um

**dio** (5.4.0) - Pra requisições HTTP. Muito melhor que o http padrão, tem interceptors, tratamento de erro decente e é fácil de configurar.

**flutter_bloc** (9.1.1) - Gerenciamento de estado com Cubit. Escolhi Cubit ao invés de Bloc puro porque é mais simples e não precisava de eventos complexos.

**equatable** (2.0.5) - Pra comparar objetos sem ter que ficar escrevendo == e hashCode na mão.

**cached_network_image** (3.4.1) - Cache de imagens. Sem isso o app fica recarregando as imagens toda hora.

**flutter_svg** (2.0.10+1) - Pra renderizar SVGs.

**mocktail** (1.0.4) - Mock pra testes. Mais simples que mockito porque não precisa de code generation.

**bloc_test** (10.0.0) - Facilita testar os Cubits.

**get_it** (8.0.3) - Injeção de dependência. Simples e direto, sem precisar de code generation igual o injectable.

## API

PokeAPI: https://pokeapi.co/api/v2/

## Features

- Lista de Pokémons com scroll infinito
- Busca por nome
- Tela de detalhes com stats e tipos
- Tratamento de erros

## Integração Nativa - Google Analytics

Implementei a integração com Google Analytics usando código nativo (Kotlin e Swift) e MethodChannel pra comunicação com o Flutter.

### Como funciona

O Flutter chama o código nativo através de um `MethodChannel`:

```
Flutter (Dart)  →  MethodChannel  →  Código Nativo (Kotlin/Swift)  →  Firebase Analytics SDK
```

### Arquivos

- `lib/src/core/analytics/google_analytics_service.dart` - Serviço Flutter que usa MethodChannel
- `android/.../MainActivity.kt` - Implementação Android com Firebase Analytics
- `ios/.../AppDelegate.swift` - Implementação iOS com Firebase Analytics

### Uso

```dart
final analytics = GoogleAnalyticsService();

// Logar evento
analytics.logEvent('button_click', {'button_name': 'favorite'});

// Logar visualização de tela
analytics.logScreenView('pokemon_detail');
```

### Por que código nativo?

Poderia ter usado o package `firebase_analytics`, mas a ideia era mostrar como fazer integração nativa com MethodChannel - útil quando precisa de algo específico que os packages não oferecem.
