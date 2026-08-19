import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Turkish and English language files contain the same keys', () {
    final turkish = _flattenKeys(_readJson('assets/lang/tr.json'));
    final english = _flattenKeys(_readJson('assets/lang/en.json'));

    expect(turkish, english);
  });

  test('presentation code does not contain direct visible string literals', () {
    final dartFiles = _presentationFiles();
    final violations = <String>[];
    final visibleTextPatterns = [
      RegExp(r'''Text\(\s*['\"][^'\"]+['\"]\s*\)'''),
      RegExp(r'''(?:labelText|hintText|helperText|tooltip):\s*['\"]'''),
    ];

    for (final file in dartFiles) {
      final lines = file.readAsLinesSync();
      for (var index = 0; index < lines.length; index++) {
        final line = lines[index];
        if (visibleTextPatterns.any((pattern) => pattern.hasMatch(line)) &&
            !line.contains('.tr(')) {
          violations.add('${file.path}:${index + 1}: ${line.trim()}');
        }
      }
    }

    expect(violations, isEmpty, reason: violations.join('\n'));
  });

  test('presentation code uses centralized visual constants', () {
    final dartFiles = _presentationFiles();
    final violations = <String>[];
    final rawVisualPatterns = [
      RegExp(r'\bColors\.'),
      RegExp(r'EdgeInsets\.[A-Za-z]+\([^)]*\b\d+(?:\.\d+)?\b'),
      RegExp(r'fontSize:\s*\d'),
      RegExp(r'BorderRadius\.circular\(\s*\d'),
    ];

    for (final file in dartFiles) {
      final lines = file.readAsLinesSync();
      for (var index = 0; index < lines.length; index++) {
        final line = lines[index];
        if (rawVisualPatterns.any((pattern) => pattern.hasMatch(line))) {
          violations.add('${file.path}:${index + 1}: ${line.trim()}');
        }
      }
    }

    expect(violations, isEmpty, reason: violations.join('\n'));
  });
}

Iterable<File> _presentationFiles() => Directory('lib')
    .listSync(recursive: true)
    .whereType<File>()
    .where(
      (file) =>
          file.path.endsWith('.dart') &&
          file.path.replaceAll('\\', '/').contains('/presentation/'),
    );

Map<String, dynamic> _readJson(String path) =>
    jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;

Set<String> _flattenKeys(Map<String, dynamic> source, [String prefix = '']) {
  final keys = <String>{};
  for (final entry in source.entries) {
    final key = prefix.isEmpty ? entry.key : '$prefix.${entry.key}';
    if (entry.value case final Map<String, dynamic> nested) {
      keys.addAll(_flattenKeys(nested, key));
    } else {
      keys.add(key);
    }
  }
  return keys;
}
