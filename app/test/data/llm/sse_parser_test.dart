import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_coach/data/llm/sse_parser.dart';

void main() {
  test('parses SSE chunks and yields delta payloads', () async {
    final sse = utf8.encode([
      'data: {"delta":"你"}\n\n',
      'data: {"delta":"好"}\n\n',
      'data: [DONE]\n\n',
    ].join());
    final stream = Stream<List<int>>.fromIterable([sse]);
    final results = await parseSse(stream).toList();
    expect(results, ['你', '好']);
  });

  test('skips non-data lines and comments', () async {
    final sse = utf8.encode([
      ':heartbeat\n\n',
      'event: ping\n\n',
      'data: {"delta":"x"}\n\n',
    ].join());
    final stream = Stream<List<int>>.fromIterable([sse]);
    final results = await parseSse(stream).toList();
    expect(results, ['x']);
  });
}