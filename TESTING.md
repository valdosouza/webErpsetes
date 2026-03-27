# Testing (appweb)

## Target platforms (produto)

Este app é entregue **apenas em Android e Web**. Não há suporte planejado para Windows desktop; use **Android (dispositivo ou emulador)** para `integration_test`.

## Stack overview

- **State:** BLoC (`bloc` / `flutter_bloc`) with **flutter_modular** for routes and `get_it`-style binds in modules.
- **HTTP:** `package:http` (see `AppModule` and feature datasources).
- **Storage:** `SharedPreferences` via `LocalStorageService` (tests should not hit real prefs unless using fakes).
- **Critical modules (regression focus):** auth + splash, home/dashboard data, order sale register, stock, drawer/cashier, printer.

## Commands

| Goal | Command |
|------|---------|
| Unit + widget + fluxos E2E no VM (sem APK) | `flutter test` |
| Integração no app real (Android) | `flutter test integration_test -d <deviceId>` |

Com vários dispositivos (`flutter devices`), escolha o Android explicitamente, por exemplo:

- `flutter test integration_test -d emulator-5554`
- `flutter test integration_test -d <id-do-seu-celular>`

**Sem emulador/dispositivo:** use só `flutter test`; o arquivo `test/integration/app_flows_vm_test.dart` repete os mesmos cenários de `integration_test/` com o binding de teste (sem instalar o app).

**Web:** o alvo `chrome` **não** roda `integration_test` no Flutter atual (`Web devices are not supported for integration tests`). Para Web, confie em `flutter test`, `flutter analyze` e testes manuais no navegador.

## Layout

- `test/unit/` — pure Dart / small widget helpers, **mocktail** mocks in `test/helpers/`.
- `test/widget/` — widget tests (`MaterialApp`, `pump` / `pumpAndSettle`).
- `test/app/modules/order_sale_register/` — models, `GetOrderMain` / `GetProductPrices`, widgets com `injectedBloc`.
- `test/integration/` — same E2E scenarios as `integration_test/`, runnable without a platform integration build.
- `integration_test/` — `IntegrationTestWidgetsFlutterBinding` + lightweight UI harness (`test_harness.dart`, no Modular/Firebase/HTTP).
- `test/test_config.dart` — shared `configureTestEnvironment()` (binding init).
- Legacy **mockito** tests remain under `test/app/modules/...`.

## Writing new tests

1. Prefer **mocktail** for new mocks (`registerFallbackValue` for custom types used with `any()`).
2. Keep tests **deterministic**: fixed dates in JSON, no real network; fake repositories or `http.testing.MockClient` where needed.
3. Widget tests: wrap with `MaterialApp` (or `MaterialApp.router` if you inject a minimal delegate/parser).
4. Avoid `pumpAndSettle` with unbounded animations; prefer `pump(Duration)` or settling only after known async work completes.

## Debugging

- Run a single file: `flutter test test/unit/foo_test.dart`.
- Verbose: `flutter test --reporter expanded`.
- IDE: use “Debug test” on a `test()` / `testWidgets()` line (VS Code / Android Studio).

## Anti-flake practices

- Do not depend on `DateTime.now()` in expectations; inject clocks or freeze dates in JSON.
- Avoid arbitrary `Future.delayed`; drive async with `pump` / `pumpAndSettle` tied to real frame or microtask completion.
- For `Image.asset`, ensure assets are declared under `flutter: assets` in `pubspec.yaml` (already required for the real app).

## CI

There is no `.github/workflows` entry in this repo yet. See `docs/ci_flutter.yml` for a commented GitHub Actions example.
