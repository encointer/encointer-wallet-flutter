// ignore_for_file: avoid_print

import 'dart:io';
import 'package:path/path.dart' as p;

void main() {
  const assetsDir = 'assets';
  const outputFile = 'lib/gen/assets.g.dart';

  final buffer = StringBuffer()
    ..writeln('// GENERATED CODE - DO NOT MODIFY BY HAND')
    ..writeln('// Run `dart run generate_assets.dart` to regenerate')
    ..writeln();

  final directory = Directory(assetsDir);
  if (!directory.existsSync()) {
    print('⚠️ The assets directory does not exist.');
    return;
  }

  final subdirectories = <String, List<File>>{};
  final files = directory.listSync(recursive: true);
  if (files.isEmpty) {
    print('⚠️ No asset files found!');
    return;
  }

  for (final file in files) {
    if (file is File) {
      final relativePath = p.relative(file.path, from: assetsDir);
      final parts = p.split(relativePath);
      if (parts.length > 1) {
        subdirectories.putIfAbsent(parts.first, () => []).add(file);
      }
    }
  }

  // Root Assets class
  buffer
    ..writeln('class Assets {')
    ..writeln('  Assets._();');

  for (final entry in subdirectories.entries) {
    final className = _capitalize(entry.key);
    buffer.writeln('  final $className ${entry.key} = $className();');
  }

  buffer.writeln('}');

  // Generate subdirectory classes
  for (final entry in subdirectories.entries) {
    final className = _capitalize(entry.key);
    buffer
      ..writeln('\nclass $className {')
      ..writeln('  $className();');

    final assetVars = <String>[];

    for (final file in entry.value) {
      final fileName = p.basename(file.path);
      final varName = _sanitizeVarName(fileName);
      final unixPath = p.normalize(file.path).replaceAll(r'\', '/');

      buffer.writeln('  final String $varName = "$unixPath";');
      assetVars.add(varName);
    }

    // Add `all` getter to return all asset paths as a list
    buffer
      ..writeln('\n  List<String> get all => [${assetVars.join(', ')}];')
      ..writeln('}');
  }

  File(outputFile).writeAsStringSync(buffer.toString());
  print('✅ Assets file generated: $outputFile');
}

String _capitalize(String text) => text[0].toUpperCase() + text.substring(1);
String _sanitizeVarName(String name) => name.replaceAll(RegExp(r'\W'), '_');
