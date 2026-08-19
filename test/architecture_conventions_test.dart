import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('domain layer has no Flutter, Firebase, Riverpod, or data imports', () {
    final violations = <String>[];
    for (final file in _dartFilesUnder('lib/features')) {
      final normalizedPath = file.path.replaceAll('\\', '/');
      if (!normalizedPath.contains('/domain/')) {
        continue;
      }
      final content = file.readAsStringSync();
      const forbiddenImports = [
        'package:flutter/',
        'package:firebase_',
        'package:cloud_firestore/',
        'package:hooks_riverpod/',
        '/data/',
        '/presentation/',
        '/services/',
      ];
      for (final forbiddenImport in forbiddenImports) {
        if (content.contains(forbiddenImport)) {
          violations.add('${file.path}: $forbiddenImport');
        }
      }
    }
    expect(violations, isEmpty, reason: violations.join('\n'));
  });

  test('presentation layer does not import data, services, or Firebase', () {
    final violations = <String>[];
    for (final file in _dartFilesUnder('lib')) {
      final normalizedPath = file.path.replaceAll('\\', '/');
      if (!normalizedPath.contains('/presentation/')) {
        continue;
      }
      final content = file.readAsStringSync();
      const forbiddenImports = [
        '/data/',
        '/services/',
        'package:firebase_',
        'package:cloud_firestore/',
      ];
      for (final forbiddenImport in forbiddenImports) {
        if (content.contains(forbiddenImport)) {
          violations.add('${file.path}: $forbiddenImport');
        }
      }
    }
    expect(violations, isEmpty, reason: violations.join('\n'));
  });

  test('color constants preserve the project UPPER_SNAKE_CASE convention', () {
    final violations = <String>[];
    final declarationPattern = RegExp(
      r'\bconst\s+Color\s+([A-Za-z_][A-Za-z0-9_]*)\s*=',
    );
    final file = File('lib/constants/colors.dart');
    for (final match in declarationPattern.allMatches(
      file.readAsStringSync(),
    )) {
      final name = match.group(1)!;
      if (name != name.toUpperCase()) {
        violations.add('${file.path}: $name');
      }
    }
    expect(violations, isEmpty, reason: violations.join('\n'));
  });
}

Iterable<File> _dartFilesUnder(String path) => Directory(path)
    .listSync(recursive: true)
    .whereType<File>()
    .where((file) => file.path.endsWith('.dart'));
