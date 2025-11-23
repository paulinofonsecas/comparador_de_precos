# Comparador de Preços 🏷️

![coverage][coverage_badge]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

Bem-vindo ao **Comparador de Preços**, um aplicativo Flutter desenvolvido para facilitar a comparação de preços de produtos em diferentes estabelecimentos, ajudando consumidores a economizar e lojistas a gerenciar seus produtos.

## 📋 Sobre o Projeto

Este aplicativo conecta consumidores e lojistas, oferecendo funcionalidades de geolocalização, busca de produtos e comparação de valores. O projeto foi construído com uma arquitetura robusta e escalável, utilizando as melhores práticas do mercado.

### Funcionalidades Principais

*   **🔍 Comparação de Preços**: Encontre o melhor preço para o produto que você deseja.
*   **🗺️ Geolocalização**: Visualize estabelecimentos próximos com integração de mapas (`flutter_map`).
*   **👤 Perfis de Usuário**:
    *   **Consumidor**: Busca produtos, cria listas e compara preços.
    *   **Lojista**: Gerencia produtos e atualiza preços.
*   **🔐 Autenticação Segura**: Login e cadastro de usuários.

## 🛠️ Tecnologias

*   **Flutter** & **Dart**
*   **Gerenciamento de Estado**: BLoC / Cubit
*   **Backend**: Integração híbrida com Firebase e Supabase
*   **Mapas**: OpenStreetMap (via `flutter_map`)

---

## 📊 Análise do Projeto

Para uma análise técnica detalhada da estrutura, arquitetura e decisões de design, consulte o arquivo [GEMINI.md](GEMINI.md).

---

## 🚀 Começando

Este projeto possui 3 ambientes (flavors):

- **development**: Para desenvolvimento diário.
- **staging**: Para testes (QA).
- **production**: Versão final.

Para rodar o projeto, utilize as configurações de lançamento do VSCode/Android Studio ou os comandos abaixo:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

_\*O Comparador de Preços funciona em iOS, Android, Web e Windows._

---

## 🧪 Testes

Para rodar todos os testes unitários e de widget:

```sh
$ flutter test --coverage --test-randomize-ordering-seed random
```

Para visualizar o relatório de cobertura (requer `lcov`):

```sh
# Gerar Relatório
$ genhtml coverage/lcov.info -o coverage/

# Abrir Relatório
$ open coverage/index.html
```

---

## 🌐 Tradução e Internacionalização

O projeto utiliza `flutter_localizations` e arquivos `.arb` para gerenciar traduções.

1.  Adicione novas strings em `lib/l10n/arb/app_pt.arb` (ou outro idioma).
2.  Rode o comando para gerar as classes:
    ```sh
    flutter gen-l10n --arb-dir="lib/l10n/arb"
    ```

---

[coverage_badge]: coverage_badge.svg
[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
