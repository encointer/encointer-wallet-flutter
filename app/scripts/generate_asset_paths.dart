import 'dart:io';
import 'package:path/path.dart' as p;

void main() {
  const String assetsDir = 'assets';
  const String outputFile = 'lib/assets.g.dart';

  final buffer = StringBuffer();
  buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
  buffer.writeln('// Run `dart run generate_assets.dart` to regenerate');
  buffer.writeln();

  final directory = Directory(assetsDir);
  if (!directory.existsSync()) {
    print('Error: The assets directory does not exist.');
    return;
  }

  final files = directory.listSync(recursive: true);
  if (files.isEmpty) {
    print('⚠️ No asset files found!');
    return;
  }

  final groupedFiles = _groupFilesBySubdirectories(files);
  _generateClasses(groupedFiles, buffer);

  File(outputFile).writeAsStringSync(buffer.toString());
  print('✅ Assets file generated: $outputFile');
}

Map<String, List<File>> _groupFilesBySubdirectories(List<FileSystemEntity> files) {
  final subdirectories = <String, List<File>>{};
  for (var file in files) {
    if (file is File) {
      final relativePath = p.relative(file.path, from: 'assets');
      final parts = p.split(relativePath);
      final subdir = parts.length > 1 ? parts.sublist(0, parts.length - 1).join('/') : '';
      subdirectories.putIfAbsent(subdir, () => []).add(file);
    }
  }
  return subdirectories;
}

void _generateClasses(Map<String, List<File>> subdirectories, StringBuffer buffer) {
  // Root Assets class
  buffer.writeln('class Assets {');
  buffer.writeln('  Assets._();');

  // Create classes for top-level directories
  for (var entry in subdirectories.entries) {
    print("entry: ${entry}");
    final className = _sanitizeClassName(entry.key);
    buffer.writeln('  static final $className ${_sanitizeVarName(entry.key)} = $className();');
  }

  buffer.writeln('}');

  // Generate the classes for each directory and nested subdirectory
  for (var entry in subdirectories.entries) {
    _generateClassForDirectory(entry.key, entry.value, subdirectories, buffer);
  }
}

void _generateClassForDirectory(
    String dir,
    List<File> files,
    Map<String, List<File>> subdirectories,
    StringBuffer buffer,
    ) {
  final className = _sanitizeClassName(dir);
  buffer.writeln('\nclass $className {');
  buffer.writeln('  const $className();');

  final assetVars = <String>[];

  // Process files in this directory
  for (var file in files) {
    final fileName = p.basename(file.path);
    final varName = _sanitizeVarName(fileName);
    final unixPath = p.normalize(file.path).replaceAll('\\', '/');
    buffer.writeln('  static const String $varName = "$unixPath";');
    assetVars.add(varName);
  }

  // Add `all` getter for this directory's assets
  buffer.writeln('\n  static List<String> get all => [${assetVars.join(', ')}];');

  // Check and create classes for subdirectories
  final nestedSubdirectories = subdirectories.keys
      .where((key) => key.startsWith('$dir/'))
      .toList();

  for (var nestedDir in nestedSubdirectories) {
    final nestedFiles = subdirectories[nestedDir]!;
    _generateClassForDirectory(nestedDir, nestedFiles, subdirectories, buffer);
  }

  buffer.writeln('}');
}

String _sanitizeClassName(String name) {
  // Replace both / and . with _ to ensure valid Dart identifiers
  return name.replaceAll(RegExp(r'[/.]'), '_');
}

String _sanitizeVarName(String name) {
  // Replace non-word characters with underscores for variable names
  return name.replaceAll(RegExp(r'\W'), '_');
}
