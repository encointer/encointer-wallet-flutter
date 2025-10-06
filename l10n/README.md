# Internationalization with l10n for the Encointer App

## Generate
Generate translations with:

```bash
flutter gen-l10n
```

The root melos has a command to execute it from the repository root.

## Test
We can test if translations have been generated for all languages with:

```bash
./scripts/check_translations.sh .untranslated-messages.txt
```