import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:gym_coach/data/llm/llm_client.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  test('client sends signed POST and parses SSE', () async {
    final mock = MockClient((req) async {
      expect(req.headers['X-Signature'], isNotEmpty);
      expect(req.headers['X-Timestamp'], isNotEmpty);
      expect(req.body, contains('"messages"'));
      return http.Response(
        'data: {"delta":"好"}\n\ndata: [DONE]\n\n',
        200,
        headers: {'content-type': 'text/event-stream'},
        encoding: utf8,
      );
    });

    final client = LlmClient(
      endpoint: 'https://example.com',
      hmacSecret: 'secret',
      httpClient: mock,
    );
    final chunks = await client.chat(
      messages: [
        {'role': 'user', 'content': 'hi'},
      ],
    ).toList();
    expect(chunks, ['好']);
  });

  test('retries on 500 and eventually succeeds', () async {
    var attempts = 0;
    final mock = MockClient((req) async {
      attempts++;
      if (attempts < 2) {
        return http.Response('boom', 500);
      }
      return http.Response(
        'data: {"delta":"ok"}\n\ndata: [DONE]\n\n',
        200,
        headers: {'content-type': 'text/event-stream'},
      );
    });
    final client = LlmClient(
      endpoint: 'https://example.com',
      hmacSecret: 's',
      httpClient: mock,
    );
    final chunks = await client.chat(messages: [
      {'role': 'user', 'content': 'hi'},
    ]).toList();
    expect(chunks, ['ok']);
    expect(attempts, 2);
  });
}