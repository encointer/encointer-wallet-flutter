# Encointer Wallet — CLAUDE.md

## Quick Reference

```bash
# Setup (run once)
./scripts/install_flutter_wrapper.sh
.flutter/bin/dart pub get
.flutter/bin/dart run melos bootstrap

# Common commands (all via melos)
.flutter/bin/dart run melos unit-test-app-exclude-e2e   # App unit tests (no e2e)
.flutter/bin/dart run melos unit-test-packages           # Package unit tests
.flutter/bin/dart run melos analyze-check                # Lint (fatal warnings)
.flutter/bin/dart run melos format-check                 # Format check (120 chars)
.flutter/bin/dart run melos format-120                   # Auto-format
.flutter/bin/dart run melos run-build-runner             # Code generation (MobX, JSON, flutter_gen)
.flutter/bin/dart run melos generate-translations        # L10n code gen
.flutter/bin/dart run melos run-android                  # Run on Android (--flavor dev)
.flutter/bin/dart run melos run-ios                      # Run on iOS
```

## Architecture

**Monorepo** managed by Melos. Flutter 3.35.0, Dart >=3.6.0. Flutter SDK lives in `.flutter/` git submodule.

### Workspace layout

```
app/                  Main Flutter app (package: encointer_wallet)
  lib/
    main.dart         Entry point, DI setup (MultiProvider + MultiRepositoryProvider)
    app.dart          WalletApp widget
    config/           Network definitions (Kusama, Rococo, Gesell, Zombienet)
    models/           Data models (14 subdirs)
    modules/          Feature modules (login, splash, settings, meetup_location, transfer, account)
    page/             UI pages (qr_scan, reap_voucher, assets, profile)
    page-encointer/   Encointer-specific pages
    presentation/     Home views
    router/           CupertinoPageRoute-based named routing
    service/          Services (13 subdirs: substrate_api, tx, forex, ipfs, meetup, etc.)
    store/            MobX stores (AppStore, AccountStore, EncointerStore, etc.)
    theme/            Theme config
    gen/              Generated assets (flutter_gen)
  test/               Unit tests (~310 files)
  integration_test/   Integration tests (integration_test framework)
  test_driver/        Legacy flutter_driver tests (kept during transition) + integration_test drivers
packages/
  endpoint_manager/   Endpoint selection & management
  ew_encointer_utils/ Encointer utility functions
  ew_format/          Formatting utilities
  ew_http/            HTTP client wrapper (http: ^1.1.2)
  ew_keyring/         Keyring & crypto (polkadart_keyring, substrate_bip39, ss58)
  ew_polkadart/       Generated Substrate types (polkadart_cli)
  ew_primitives/      Encointer domain primitives
  ew_storage/         Storage abstractions (shared_preferences, flutter_secure_storage)
  ew_substrate_fixed/ Fixed-point number handling
  ew_test_keys/       Test account keys
  log/                Logging
l10n/                 Localization package (en, de, fr, ru, sw)
```

### Key patterns

- **State management**: MobX with code generation (`*.g.dart`). Stores in `app/lib/store/`.
- **DI**: Provider pattern with custom `RepositoryProvider` (flutter_bloc-style).
- **Blockchain**: Polkadart for Substrate/Polkadot interaction. Generated types in `ew_polkadart`.
- **Routing**: `CupertinoPageRoute` with `onGenerateRoute` in `app/lib/router/app_router.dart`.
- **Serialization**: `json_serializable` + custom `json_serializable_mobx` (git dependency).

### Networks

Encointer Kusama (production), Rococo (testnet), Gesell, Gesell-Dev, Zombienet Local. Configurable via `WS_ENDPOINT` env var.

## Testing

### Unit tests

```bash
.flutter/bin/dart run melos unit-test-app-exclude-e2e   # App tests (excludes e2e tags)
.flutter/bin/dart run melos unit-test-packages           # All packages except app
```

Test tags: `encointer-node-e2e`, `production-e2e`, `endpoint-health-e2e`. Default runs exclude all e2e tags.

### E2E tests (require running node)

```bash
.flutter/bin/dart run melos unit-test-app-with-encointer-node-e2e
.flutter/bin/dart run melos unit-test-app-with-production-e2e
```

### Integration tests (device/emulator)

Uses `integration_test` framework (replaces deprecated `flutter_driver`). Tests live in `app/integration_test/`, drivers in `app/test_driver/`.

```bash
.flutter/bin/dart run melos integration-app-test-android   # Android (--flavor dev)
.flutter/bin/dart run melos integration-app-test-ios        # iOS
.flutter/bin/dart run melos integration-qr-payment-story    # Multi-device QR payment story
```

Structure: `app/integration_test/app/` mirrors `test_driver/app/` (1:1 port). Single `testWidgets` in `app_test.dart` runs all ~65 tests sequentially (app state accumulates). User story tests in `integration_test/stories/`.

Key differences from flutter_driver: `WidgetTester` instead of `FlutterDriver`, `find.byKey(Key(...))` instead of `find.byValueKey(...)`, direct `AppSettings` manipulation instead of `driver.requestData()`, `find.byTooltip('Back')` instead of `find.pageBack()`.

`app/build.yaml` excludes `integration_test/**` from build_runner sources to avoid json_serializable builder conflicts.

Mock framework: **mocktail**. Tests mirror source structure under `app/test/`.

## Code Generation

Generated files: `*.g.dart` (MobX, JSON), `app/lib/gen/` (flutter_gen), `packages/ew_polkadart/lib/generated/`.

```bash
.flutter/bin/dart run melos run-build-runner        # MobX stores, JSON serialization, flutter_gen
.flutter/bin/dart run melos run-polkadart-generate  # Substrate types (then: dart fix --apply && melos format-120)
.flutter/bin/dart run melos generate-translations   # L10n from ARB files
```

CI verifies generated files are committed: runs build_runner + format, then `git diff --exit-code`.

## Linting

- Base: `very_good_analysis` (strict)
- Line length: **120**
- Analysis excludes: `*.g.dart`, `*.freezed.dart`
- Key enabled rules: `unawaited_futures`, `avoid_dynamic_calls`, `no_default_cases`
- Key disabled: `public_member_api_docs`, `lines_longer_than_80_chars`, `require_trailing_commas`

## Build Flavors (Android)

- **dev** — development (version suffix `-dev`)
- **play** — Google Play release (signed)
- **fdroid** — F-Droid release

Android: minSdk 21, targetSdk 36, Java 17, NDK 28.2.13676358.

## CI Matrix (unit_tests.yml)

Runs on push/PR to `master` and `f-droid`: `analyze-check`, `format-check`, `unit-test-packages`, `unit-test-app-exclude-e2e`. Separate job checks code generation is up-to-date.

## Branches

- `master` — main development
- `beta` — beta releases (AppCenter auto-deploy)
- `f-droid` — F-Droid specific (different QR scanner lib)
