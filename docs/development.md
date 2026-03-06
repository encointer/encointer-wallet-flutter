# Development

## Formatting

`dart format` lacks config file support, which implies that customizations need to be done by users individually. The default
limit of 80 characters line length conflicts with the deeply nested structure of flutter's declarative code for designing
widgets. This causes many unwanted linebreaks that reduce the readability of flutter code. Hence, we increase the line
length of the code to 120.

* Settings > Dart > Line length 120.
* Autoformat on save: Settings > Languages and Frameworks > then tick: `Format code on save`, `Organize imports on save`.
* Format the whole codebase with:
```shell
.flutter/bin/dart run melos format-120
```

### Other fmt hints:

* Define formatting with the help of [trailing commas](https://docs.flutter.dev/development/tools/formatting#using-trailing-commas).
* [Dartfmt FAQ](https://github.com/dart-lang/dart_style/wiki/FAQ).

## Update generated files

The flutter build-runner is used to generate repetitive boiler-plate code that is generated based on code annotations,
e.g. `@JsonSerializable` or the mobx annotations. Whenever annotations are added, changed or removed, the following
command must be run to update the `*.g` files.

```shell
.flutter/bin/dart run melos run-build-runner
```

Update polkadart generated files
```shell
.flutter/bin/dart run melos run-polkadart-generate
# Fix analyzer issues
.flutter/bin/dart fix . --apply
.flutter/bin/dart run melos format-120
```
